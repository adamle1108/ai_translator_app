

import 'SelectLanguageController.dart';
import 'package:get/get.dart';

class SelectLanguageBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SelectLanguageController(),);
  }
}