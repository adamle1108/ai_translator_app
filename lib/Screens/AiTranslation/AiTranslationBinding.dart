
import 'AiTranslationController.dart';
import 'package:get/get.dart';

class AiTranslationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AiTranslationController(),);
  }
}