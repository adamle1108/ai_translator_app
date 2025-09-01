import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constant/FontFamily.dart';
import '../../routes/app_routes.dart';
import '../../widgets/textfield.dart';
import 'GrammarController.dart';
import 'package:get/get.dart';

class GrammarView extends GetView<GrammarController> {
  const GrammarView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.hintColor,
        title: Text(
          "Grammar Correction",
          style: context.textTheme.headlineMedium,
        ),
      ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<GrammarController>(builder: (controller) {
              return SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height: height / 3,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          AppTextField(
                            maxLines: 6,
                            hintText: tr("Enter Text"),
                            controller: controller.textFieldController,
                            onTap: () {
                
                            },
                            onChanged: (value) {
                              controller.update();
                            },
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.speechToText.isNotListening
                                      ? controller.startListening()
                                      : controller.stopListening();
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.mic,
                                      color: controller.speechToText.isListening ?context.theme.focusColor :context.theme.primaryColor,
                                      size: 30,
                                    ),
                                    Text(
                                      "Voice",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: poppins,
                                          fontWeight: FontWeight.bold,
                                          color: controller.speechToText.isListening ?context.theme.focusColor :context.theme.primaryColor
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GetBuilder<GrammarController>(
                    builder: (controller) {
                      return controller.textFieldController.text.isNotEmpty
                          ? GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          controller
                              .translationText(
                              controller.textFieldController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: context.theme.focusColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text("Check",
                                style: TextStyle(
                                    color: context.theme.hintColor,
                                    fontSize: 20,
                                    fontFamily: poppins,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )
                          : const SizedBox();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (controller.isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: context.theme.focusColor,
                      ),
                    ),
                  if (controller.correctionAiResponse.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: context.theme.hintColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.correctionAiResponse,
                              style: context.textTheme.headlineSmall,
                            ),
                
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(text: controller.correctionAiResponse));
                                  },
                                  child: Icon(
                                    Icons.copy,
                                    color: context.theme.primaryColor,
                                    size: 25,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                ],),
              );
            },),
          ),
    ));
  }
}
