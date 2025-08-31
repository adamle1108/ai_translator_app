import 'package:aivoicetranslation/Screens/TranslationScreen/TranslationController.dart';
import 'package:get/get.dart';

class TranslationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => TranslationController(),);
  }
}