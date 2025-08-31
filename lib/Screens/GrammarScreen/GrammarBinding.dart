

import 'GrammarController.dart';
import 'package:get/get.dart';

class GrammarBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => GrammarController(),);
  }
}