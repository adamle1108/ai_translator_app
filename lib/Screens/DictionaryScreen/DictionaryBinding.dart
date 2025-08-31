
import 'DictionaryController.dart';
import 'package:get/get.dart';

class DictionaryBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DictionaryController(),);
  }
}