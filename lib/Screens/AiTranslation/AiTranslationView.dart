import 'package:aivoicetranslation/Screens/AiTranslation/AiTranslationController.dart';
import 'package:aivoicetranslation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../widgets/ChatWidget.dart';

class AiTranslationView extends GetView<AiTranslationController> {
  const AiTranslationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.hintColor,
        title: Text(
          "Language AI",
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<AiTranslationController>(
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
                                "selectedFrom": true,
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
                              await controller.flutterTts.setLanguage(controller
                                  .toLanguageCode); // Set the language to English (US)
                              await controller.flutterTts.speak(controller
                                  .conversations[index].text); // Speak the text
                            },
                          );
                        })),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.theme.hintColor),
                    child: AppTextField(
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 500)).then((value) {
                          controller.scrollToEnd();
                        },);
                      },
                      hintText: "Enter Text",
                      controller: controller.textController,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.translationText(
                                controller.textController.text);
                            FocusScope.of(context).unfocus();
                          },
                          icon: Icon(
                            Icons.send,
                            color: context.theme.primaryColor,
                          )),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}
