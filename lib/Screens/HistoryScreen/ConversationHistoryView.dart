
import 'package:flutter/material.dart';
import '../../widgets/ChatWidget.dart';
import 'HistoryController.dart';
import 'package:get/get.dart';

class ConversationHistoryView extends GetView<HistoryController> {
  const ConversationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HistoryController>(builder: (controller) {
        return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.allConversation.length,
            shrinkWrap: true,
            reverse: false,
            itemBuilder: (context, index) {
              return Column(children: [
                ChatWidget(
                  msg: controller.allConversation[index].text,
                  isUser: true,
                  onTapVoice: () {},
                ),
                ChatWidget(
                  msg: controller.allConversation[index].answer,
                  isUser: false,
                  onTapVoice: () async {
                    // await controller.flutterTts.setLanguage(controller.toLanguageCode); // Set the language to English (US)
                    await controller.flutterTts.speak( controller.allConversation[index].answer); // Speak the text
                  },
                )
              ],);
            });
      },),
    );
  }
}
