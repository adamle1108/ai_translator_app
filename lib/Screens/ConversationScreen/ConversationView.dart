import '../../routes/app_routes.dart';
import '../../widgets/ChatWidget.dart';
import 'ConversationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationView extends GetView<ConversationController> {
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.hintColor,
        title: Text(
          "Conversation",
          style: context.textTheme.headlineMedium,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetBuilder<ConversationController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: FloatingActionButton(
              backgroundColor: controller.speechToText.isNotListening
                  ? context.theme.primaryColor
                  : context.theme.focusColor,
              shape: const CircleBorder(),
              child:  Icon(
                Icons.mic,
                color: context.theme.hintColor
              ),
              onPressed: () {
                controller.speechToText.isNotListening
                    ? controller.startListening()
                    : controller.stopListening();
              }, // Add your onPressed callback here
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ConversationController>(
          builder: (controller) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final result = await Get.toNamed(
                              Routes.selectLanguageView,
                              arguments: {
                                "fromLanguage": controller.fromLanguage,
                                "toLanguage": controller.toLanguage,
                                "selectedFrom": true
                              });
                          if (result != null) {
                            controller.onChangeLanguage(result);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: context.theme.hintColor),
                          child: Text(
                            controller.fromLanguage,
                            style: context.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.focusColor),
                        child: Icon(
                          Icons.rotate_right,
                          color: context.theme.hintColor,
                          size: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final result = await Get.toNamed(
                              Routes.selectLanguageView,
                              arguments: {
                                "fromLanguage": controller.fromLanguage,
                                "toLanguage": controller.toLanguage,
                                "selectedFrom": false
                              });
                          if (result != null) {
                            controller.onChangeLanguage(result);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: context.theme.hintColor),
                          child: Text(
                            controller.toLanguage,
                            style: context.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.conversations.length,
                        shrinkWrap: true,
                        reverse: false,
                        itemBuilder: (context, index) {
                          return ChatWidget(
                            msg: controller.conversations[index].text,
                            isUser: controller.conversations[index].isUser,
                            onTapVoice: () async {
                              // await controller.flutterTts.setLanguage(controller.toLanguageCode); // Set the language to English (US)
                              await controller.flutterTts.speak(controller
                                  .conversations[index].text); // Speak the text
                            },
                          );
                        })),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
