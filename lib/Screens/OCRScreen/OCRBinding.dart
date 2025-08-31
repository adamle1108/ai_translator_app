
import 'OCRController.dart';
import 'package:get/get.dart';

class OCRBinding extends Bindings
{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => OCRController(),);
  }
}