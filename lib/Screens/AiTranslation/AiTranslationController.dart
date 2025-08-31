import 'dart:io';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../../Model/convarsation.dart';
import '../../SharePrefHelper/SharePref.dart';
import '../../SharePrefHelper/SharePrefKey.dart';
import '../../constant/Appkey.dart';
import '../../routes/app_routes.dart';
import '../PremiumScreen/PremiumController.dart';

class AiTranslationController extends GetxController{
  ScrollController scrollController = ScrollController();
  TextEditingController  textController = TextEditingController();
  String fromLanguage = "English";
  String correctionAiResponse = "";
  String toLanguageCode = "hi";
  bool isLoading= false;
  String toLanguage = "Hindi";
  late FlutterTts flutterTts;
  bool get isIOS =>  Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  bool speechEnabled = false;
  String lastWords = '';
  List<ChatModel> conversations = [];
  String demoText = "Hello I'm an AI assistant.I will help you quickly and correctly translate any text.You can also ask me anything.I'II be glad to help you.Let's start with your translation";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initTts();
    OpenAI.apiKey = apiKey;
    conversations.add(ChatModel(false, demoText));
  }
  onChangeLanguage(final language)
  {
    fromLanguage = language['fromLanguage'];
    toLanguage = language['toLanguage'];
    toLanguageCode = language['languageCode'];
    update();
  }

  translationText(String text)
  async {

    conversations.add(ChatModel(true, text));
    correctionAiResponse = "";
    isLoading =true;
    update();
    final OpenAI openai = OpenAI.instance;

    /// the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "give me answer it into $toLanguage ?",
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
      conversations.add(ChatModel(false, correctionAiResponse));
      scrollToEnd();
      textController.text = "";
      isLoading = false;
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
      conversations.add(ChatModel(false, correctionAiResponse));
      scrollToEnd();
      textController.text = "";
      isLoading = false;
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
  @override
  void onClose() {
    // TODO: implement onClose
    flutterTts.stop();
    super.onClose();
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