
import 'package:aivoicetranslation/Screens/PhrasesScreen/PhrasesController.dart';
import 'package:get/get.dart';

class PhrasesBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
   Get.lazyPut(() => PhrasesController(),);
  }
}