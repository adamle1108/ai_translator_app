import 'package:get/get.dart';

class SelectLanguageController extends GetxController {
  Map<String, dynamic> argument = Get.arguments;
  String fromLanguage = "English";
  bool selectedFrom = true;
  String toLanguage = "Hindi";
  String selectedLanguageCode = "hi-IN";
  List language = [
    "English",
    "Chinese",
    "Spanish",
    "Hindi",
    "French",
    "Arabic",
    "Bengali",
    "Russian",
    "Portuguese",
    "Indonesian",
    "Urdu",
    "Japanese",
    "German",
    "Korean",
    "Italian",
    "Turkish",
    "Vietnamese",
    "Polish",
    "Persian",
    "Thai",
    "Swahili",
    "Tamil",
    "Marathi",
    "Telugu",
    "Dutch",
    "Greek",
    "Czech",
    "Malay",
    "Hebrew",
    "Romanian",
  ];
  List languageCodes = [
    "en-US", // English
    "zh-CN", // Chinese
    "es-ES", // Spanish
    "hi-IN", // Hindi
    "fr-FR", // French
    "ar-SA", // Arabic
    "bn-BD", // Bengali
    "ru-RU", // Russian
    "pt-PT", // Portuguese
    "id-ID", // Indonesian
    "ur-PK", // Urdu
    "ja-JP", // Japanese
    "de-DE", // German
    "ko-KR", // Korean
    "it-IT", // Italian
    "tr-TR", // Turkish
    "vi-VN", // Vietnamese
    "pl-PL", // Polish
    "fa-IR", // Persian
    "th-TH", // Thai
    "sw-TZ", // Swahili
    "ta-IN", // Tamil
    "mr-IN", // Marathi
    "te-IN", // Telugu
    "nl-NL", // Dutch
    "el-GR", // Greek
    "cs-CZ", // Czech
    "ms-MY", // Malay
    "he-IL", // Hebrew
    "ro-RO", // Romanian
  ];
  List languageFlag = [
    "English.png",
    "Chinese.png",
    "Spanish.png",
    "Hindi.png",
    "French.png",
    "Arabic.png",
    "Bengali.png",
    "russian.png",
    "Portuguese.png",
    "Indonesian.png",
    "Urdu.png",
    "Japanese.png",
    "German.png",
    "Korean.png",
    "Italian.png",
    "Turkish.png",
    "Vietnamese.png",
    "Polish.png",
    "Persian.png",
    "Thai.png",
    "Swahili.png",
    "tamil.png",
    "marathi.png",
    "telugu.png",
    "Dutch.png",
    "Greek.png",
    "Czech.png",
    "Malay.png",
    "Hebrew.png",
    "Romanian.png",
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fromLanguage = argument['fromLanguage'];
    toLanguage = argument['toLanguage'];
    selectedFrom = argument['selectedFrom'];
    update();
  }

  changeSelected(bool value) {
    selectedFrom = value;
    update();
  }

  onChangeFrom(int index) {
    fromLanguage = language[index];
    print(selectedLanguageCode);

    update();
  }

  onChangeTo(int index) {
    toLanguage = language[index];
    selectedLanguageCode = languageCodes[index];
    update();
  }
}
