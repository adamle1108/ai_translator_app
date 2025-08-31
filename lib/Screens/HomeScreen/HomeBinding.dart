

import 'package:get/get.dart';
import 'HomeController.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeController(),);
  }
}