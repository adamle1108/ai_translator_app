
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../Model/convarsation.dart';
import '../../Model/translation.dart';
import '../../SharePrefHelper/SharePref.dart';
import '../../SharePrefHelper/SharePrefKey.dart';
import '../../constant/Appkey.dart';
import '../../constant/DatabaseHelper.dart';
import '../../routes/app_routes.dart';
import '../PremiumScreen/PremiumController.dart';

class ConversationController extends GetxController{
  ScrollController scrollController = ScrollController();
  String fromLanguage = "English";
  String text = "";
  final dbHelper = DatabaseHelper();
  String correctionAiResponse = "";
  String toLanguageCode = "hi-IN";
  bool isLoading= false;
  String toLanguage = "Hindi";
  late FlutterTts flutterTts;
  SpeechToText speechToText = SpeechToText();
  bool get isIOS =>  Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  bool speechEnabled = false;
  String lastWords = '';
  List<ChatModel> conversations = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initSpeech();
    initTts();
    OpenAI.apiKey = apiKey;
  }
  @override
  void onClose() {
    // TODO: implement onClose
    flutterTts.stop();
    super.onClose();
  }

  onChangeLanguage(final language)
  {
    fromLanguage = language['fromLanguage'];
    toLanguage = language['toLanguage'];
    toLanguageCode = language['languageCode'];
    update();
  }
  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
    update();
  }
  translationText(String text)
  async {
    correctionAiResponse = "";
    isLoading =true;
    update();
    final OpenAI openai = OpenAI.instance;

    /// the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "You will be provided with a sentence in $fromLanguage, and your task is to translate it into $toLanguage.",
        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );

    /// the user message that will be sent to the request.
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          text,
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    final requestMessages = [
      systemMessage,
      userMessage,
    ];


    if(Get.find<PremiumController>().isPremium)
    {
      /// the actual request.
      OpenAIChatCompletionModel chatCompletion = await openai.chat.create(
        model: "gpt-4-turbo",
        messages: requestMessages,
        temperature: 0.2,
        maxTokens: 500,
      );
      var aiResponseText = chatCompletion.choices.first.message.content
          ?.map((item) => item.text)
          .join();
      correctionAiResponse = aiResponseText!;
      dbHelper.insertConversation(TranslationModel(text: text, answer: correctionAiResponse));
      conversations.add(ChatModel(false, correctionAiResponse));
      isLoading = false;
      scrollToEnd();
      update();

    }else if(freeLimit > 0)
    {
      freeLimit--;
      storeFreeLimit();
      /// the actual request.
      OpenAIChatCompletionModel chatCompletion = await openai.chat.create(
        model: "gpt-4-turbo",
        messages: requestMessages,
        temperature: 0.2,
        maxTokens: 500,
      );
      var aiResponseText = chatCompletion.choices.first.message.content
          ?.map((item) => item.text)
          .join();
      correctionAiResponse = aiResponseText!;
      dbHelper.insertConversation(TranslationModel(text: text, answer: correctionAiResponse));
      conversations.add(ChatModel(false, correctionAiResponse));
      isLoading = false;
      scrollToEnd();
      update();

    }else{
      Get.toNamed(Routes.premiumView);
    }


  }
  storeFreeLimit()
  async {
    SharedPref.saveInt(SharePrefKey.freeLimit, freeLimit);
    freeLimit = await SharedPref.readInt(SharePrefKey.freeLimit);
    update();
  }
  /// Each time to start a speech recognition session
  void startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    update();
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    await speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    text = "";
    if(result.finalResult)
      {
        text = result.recognizedWords;
        conversations.add(ChatModel(true, text));
        scrollToEnd();
        translationText(text);

      }
    update();
  }


  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  void scrollToEnd() {
    // scrollController.animateTo(
    //   scrollController.position.maxScrollExtent,
    //   duration: const Duration(milliseconds: 100),
    //   curve: Curves.fastOutSlowIn,
    // );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
    update();
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }
  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      print("Playing");
      update();
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
    });

    flutterTts.setCancelHandler(() {
      print("Cancel");

    });

    flutterTts.setPauseHandler(() {
      print("Paused");
    });

    flutterTts.setContinueHandler(() {
      print("Continued");
    });

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
    });
  }
}