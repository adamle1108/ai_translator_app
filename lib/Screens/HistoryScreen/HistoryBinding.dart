import 'package:aivoicetranslation/Screens/HistoryScreen/HistoryController.dart';
import 'package:get/get.dart';

class HistoryBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HistoryController(),);
  }
}