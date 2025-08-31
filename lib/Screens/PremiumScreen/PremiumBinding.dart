


import 'package:get/get.dart';
import 'PremiumController.dart';

class PremiumBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PremiumController(),);
  }
}