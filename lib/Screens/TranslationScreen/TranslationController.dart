import 'dart:io';

import 'package:aivoicetranslation/Model/translation.dart';
import 'package:aivoicetranslation/SharePrefHelper/SharePrefKey.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../SharePrefHelper/SharePref.dart';
import '../../constant/Appkey.dart';
import '../../constant/DatabaseHelper.dart';
import '../../routes/app_routes.dart';
import '../PremiumScreen/PremiumController.dart';

class TranslationController extends GetxController {
  Map<String, dynamic>? argument = Get.arguments;
  RxString selectedModel = tr("Translate Expert").obs;

  final ImagePicker _picker = ImagePicker();
  File? _image;

  // INPUT
  final TextEditingController textFieldController = TextEditingController();
  final int maxChars = 5000;

  // LANGUAGES
  String fromLanguage = "English";
  String fromLanguageCode = "en-US";
  String toLanguage = "Hindi";
  String toLanguageCode = "hi-IN";

  // RESULT
  String correctionAiResponse = "";
  bool isLoading = false;

  // OPTIONS
  bool showPhonetic = true; // Hiển thị phiên âm


  // SPEECH/TTS
  late FlutterTts flutterTts;
  final SpeechToText speechToText = SpeechToText();
  bool get isIOS => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  bool speechEnabled = false;

  // SERVICES
  final dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    _initSpeech();
    initTts();
    OpenAI.apiKey = apiKey;

    if (argument != null && (argument?['text'] ?? '').toString().isNotEmpty) {
      textFieldController.text = argument!['text'];
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);

    if (pickedImage != null) {
      _image = File(pickedImage.path);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final inputImage = InputImage.fromFile(_image!);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      String text = recognizedText.text;
      textRecognizer.close();
      Get.toNamed(Routes.oCRView, arguments: {"image": _image, "text": text});
    }
  }

  // === Language changes ===
  void onChangeLanguage(final language) {
    // Kỳ vọng trả về đủ 4 key dưới đây
    fromLanguage = language['fromLanguage'] ?? fromLanguage;
    toLanguage = language['toLanguage'] ?? toLanguage;
    fromLanguageCode = language['fromLanguageCode'] ?? fromLanguageCode;
    toLanguageCode = language['toLanguageCode'] ?? toLanguageCode;
    update();
  }

  void swapLanguage() {
    final tLang = fromLanguage;
    fromLanguage = toLanguage;
    toLanguage = tLang;
    final tCode = fromLanguageCode;
    fromLanguageCode = toLanguageCode;
    toLanguageCode = tCode;
    // (giữ nguyên nội dung nhập/kết quả để người dùng chủ động bấm Dịch lại)
    update();
  }

  // === Options ===
  void togglePhonetic() {
    showPhonetic = !showPhonetic;
    update();
  }

  // === Input helpers ===
  void clearInput() {
    textFieldController.clear();
    update();
  }

  // === Speech-to-Text ===
  Future<void> _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    update();
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    update();
  }

  Future<void> stopListening() async {
    await speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    textFieldController.text = result.recognizedWords;
    update();
  }

  // === TTS ===
  Future<void> speakSource() async {
    if (textFieldController.text.trim().isEmpty) return;
    await flutterTts.setLanguage(fromLanguageCode);
    await flutterTts.speak(textFieldController.text);
  }

  Future<void> speakTarget() async {
    if (correctionAiResponse.trim().isEmpty) return;
    await flutterTts.setLanguage(toLanguageCode);
    await flutterTts.speak(correctionAiResponse);
  }

  Future<void> _setAwaitOptions() async =>
      flutterTts.awaitSpeakCompletion(true);
  Future<void> _getDefaultEngine() async =>
      print(await flutterTts.getDefaultEngine);
  Future<void> _getDefaultVoice() async =>
      print(await flutterTts.getDefaultVoice);

  void initTts() {
    flutterTts = FlutterTts();
    _setAwaitOptions();
    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
    flutterTts.setStartHandler(() {
      update();
    });
    flutterTts.setCompletionHandler(() {});
    flutterTts.setCancelHandler(() {});
    flutterTts.setPauseHandler(() {});
    flutterTts.setContinueHandler(() {});
    flutterTts.setErrorHandler((msg) => print("TTS error: $msg"));
  }

  // === Translate ===
  Future<void> translationText(String text) async {
    correctionAiResponse = "";
    isLoading = true;
    update();

    final openai = OpenAI.instance;

    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "You are $selectedModel AI model. You will be provided with a sentence in $fromLanguage, and your task is to translate it into $toLanguage."
        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );

    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(text)],
      role: OpenAIChatMessageRole.user,
    );

    final requestMessages = [systemMessage, userMessage];

    try {
      if (Get.find<PremiumController>().isPremium || freeLimit > 0) {
        if (!Get.find<PremiumController>().isPremium) await storeFreeLimit();

        final chatCompletion = await openai.chat.create(
          model: "gpt-4-turbo",
          messages: requestMessages,
          temperature: 0.2,
          maxTokens: 500,
        );

        final aiResponseText = chatCompletion.choices.first.message.content
            ?.map((item) => item.text)
            .join();

        correctionAiResponse = aiResponseText ?? "";
        dbHelper.insertTranslation(
            TranslationModel(text: text, answer: correctionAiResponse));
      } else {
        Get.toNamed(Routes.premiumView);
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> storeFreeLimit() async {
    freeLimit--;
    await SharedPref.saveInt(SharePrefKey.freeLimit, freeLimit);
    freeLimit = await SharedPref.readInt(SharePrefKey.freeLimit);
    Get.forceAppUpdate();
  }

  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }
}
