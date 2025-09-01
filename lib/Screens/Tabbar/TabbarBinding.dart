import 'package:aivoicetranslation/Screens/DictionaryScreen/DictionaryController.dart';
import 'package:aivoicetranslation/Screens/HomeScreen/HomeController.dart';
import 'package:aivoicetranslation/Screens/Tabbar/TabbarScreen.dart';
import 'package:get/get.dart';

import '../ConversationScreen/ConversationController.dart';
import '../PhrasesScreen/PhrasesController.dart';

class TabbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DictionaryController());
    Get.lazyPut(() => PhrasesController());
    Get.lazyPut(() => ConversationController());
  }
}
