import 'package:aivoicetranslation/Screens/SubPhrasesScreen/SubPhrasesController.dart';
import 'package:get/get.dart';

class SubPhrasesBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SubPhrasesController(),);
  }
}