import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constant/AppAssets.dart';
import 'HistoryController.dart';
import 'package:get/get.dart';

class TranslationHistoryView extends GetView<HistoryController> {
  const TranslationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HistoryController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.allTranslation.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: context.theme.hintColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.allTranslation[index].text,
                        style: TextStyle(
                            color: context.theme.shadowColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        controller.allTranslation[index].answer,
                        style: TextStyle(
                            color: context.theme.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: controller.allTranslation[index].answer));
                            },
                            child: Icon(
                              Icons.copy,
                              color: context.theme.focusColor,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () async {
                              // await controller.flutterTts.setLanguage(controller.toLanguageCode); // Set the language to English (US)
                              await controller.flutterTts.speak(controller.allTranslation[index].answer); // Speak the text
                            },
                            child: Image.asset(AppAssets.soundIcon,height: 25,width: 25,color: context.theme.focusColor,),
                          ),
                          const SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              controller.dbHelper.deleteTranslation(controller.allTranslation[index].id!);
                              controller.getHistory();
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
