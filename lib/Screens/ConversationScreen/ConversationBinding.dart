
import 'ConversationController.dart';
import 'package:get/get.dart';

class ConversationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ConversationController(),);
  }
}