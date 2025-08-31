import 'package:aivoicetranslation/Screens/AiTranslation/AiTranslationBinding.dart';
import 'package:aivoicetranslation/Screens/AiTranslation/AiTranslationView.dart';
import 'package:aivoicetranslation/Screens/ConversationScreen/ConversationBinding.dart';
import 'package:aivoicetranslation/Screens/ConversationScreen/ConversationView.dart';
import 'package:aivoicetranslation/Screens/DictionaryScreen/DictionaryBinding.dart';
import 'package:aivoicetranslation/Screens/DictionaryScreen/DictionaryVIew.dart';
import 'package:aivoicetranslation/Screens/GrammarScreen/GrammarBinding.dart';
import 'package:aivoicetranslation/Screens/GrammarScreen/GrammarView.dart';
import 'package:aivoicetranslation/Screens/HistoryScreen/HistoryBinding.dart';
import 'package:aivoicetranslation/Screens/HistoryScreen/HistoryView.dart';
import 'package:aivoicetranslation/Screens/HomeScreen/HomeBinding.dart';
import 'package:aivoicetranslation/Screens/HomeScreen/HomeView.dart';
import 'package:aivoicetranslation/Screens/OCRScreen/OCRBinding.dart';
import 'package:aivoicetranslation/Screens/OCRScreen/OCRView.dart';
import 'package:aivoicetranslation/Screens/PhrasesScreen/PhrasesBinding.dart';
import 'package:aivoicetranslation/Screens/PhrasesScreen/PhrasesView.dart';
import 'package:aivoicetranslation/Screens/PremiumScreen/PremiumBinding.dart';
import 'package:aivoicetranslation/Screens/SelectLanguage/SelectLanguageBinding.dart';
import 'package:aivoicetranslation/Screens/SelectLanguage/SelectLanguageView.dart';
import 'package:aivoicetranslation/Screens/SettingScreen/SettingBinding.dart';
import 'package:aivoicetranslation/Screens/SettingScreen/SettingController.dart';
import 'package:aivoicetranslation/Screens/SettingScreen/SettingView.dart';
import 'package:aivoicetranslation/Screens/SubPhrasesScreen/SubPhrasesBInding.dart';
import 'package:aivoicetranslation/Screens/SubPhrasesScreen/SubPhrasesView.dart';
import 'package:aivoicetranslation/Screens/TranslationScreen/TranslationBinding.dart';
import 'package:aivoicetranslation/Screens/TranslationScreen/TranslationView.dart';
import 'package:get/get.dart';
import '../Screens/PremiumScreen/PremiumView.dart';
import '../Screens/splashScreen/SplashScreenBinding.dart';
import '../Screens/splashScreen/splashScreenView.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  //static const INITIAL = Routes.homeView;
  static const initial = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: Paths.splashScreen,
      page: () => const SplashScreenView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Paths.homeScreen,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Paths.translationScreen,
      page: () => const TranslationView(),
      binding: TranslationBinding(),
    ),
    GetPage(
      name: Paths.selectLanguageView,
      page: () => const SelectLanguageView(),
      binding: SelectLanguageBinding(),
    ),
    GetPage(
      name: Paths.settingView,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Paths.historyView,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: Paths.conversationView,
      page: () => const ConversationView(),
      binding: ConversationBinding(),
    ),
    GetPage(
      name: Paths.oCRView,
      page: () => const OCRView(),
      binding: OCRBinding(),
    ),
    GetPage(
      name: Paths.phrasesView,
      page: () => const PhrasesView(),
      binding: PhrasesBinding(),
    ),
    GetPage(
      name: Paths.subPhrasesView,
      page: () => const SubPhrasesView(),
      binding: SubPhrasesBinding(),
    ),
    GetPage(
      name: Paths.dictionaryView,
      page: () => const DictionaryView(),
      binding: DictionaryBinding(),
    ),
    GetPage(
      name: Paths.aiTranslationView,
      page: () => const AiTranslationView(),
      binding: AiTranslationBinding(),
    ),
    GetPage(
      name: Paths.grammarView,
      page: () => const GrammarView(),
      binding: GrammarBinding(),
    ),
    GetPage(
      name: Paths.premiumView,
      page: () => const PremiumView(),
      binding: PremiumBinding(),
    ),
  ];
}
