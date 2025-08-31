import 'package:aivoicetranslation/constant/AppAssets.dart';
import 'package:aivoicetranslation/constant/FontFamily.dart';
import 'package:flutter/material.dart';
import 'SelectLanguageController.dart';
import 'package:get/get.dart';

class SelectLanguageView extends GetView<SelectLanguageController> {
  const SelectLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.hintColor,
        title: Text(
          "Language",
          style: context.textTheme.headlineMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.back(result: {
                  "fromLanguage" : controller.fromLanguage,
                  "toLanguage" : controller.toLanguage,
                  "languageCode" : controller.selectedLanguageCode
                });
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: context.theme.focusColor, shape: BoxShape.circle),
                child: Icon(
                  Icons.done,
                  color: context.theme.hintColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<SelectLanguageController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => controller.changeSelected(true),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.selectedFrom
                                ? context.theme.focusColor
                                : context.theme.hintColor),
                        child: Text(
                          "From : ${controller.fromLanguage}",
                          style: controller.selectedFrom
                              ? TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.theme.hintColor,
                                  fontFamily: poppins,
                                  fontSize: 16)
                              : context.textTheme.headlineSmall,
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => controller.changeSelected(false),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.selectedFrom
                                ? context.theme.hintColor
                                : context.theme.focusColor),
                        child: Text(
                          "To : ${controller.toLanguage}",
                          style: controller.selectedFrom
                              ? context.textTheme.headlineSmall
                              : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.theme.hintColor,
                                  fontFamily: poppins,
                                  fontSize: 16),
                        ),
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                controller.selectedFrom
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: controller.language.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => controller.onChangeFrom(index),
                              tileColor: controller.language[index] ==
                                      controller.fromLanguage
                                  ? context.theme.hintColor
                                  : null,
                              leading: CircleAvatar(
                                foregroundImage: AssetImage(
                                    AppAssets.basePathImages +
                                        controller.languageFlag[index]),
                              ),
                              title: Text(
                                controller.language[index],
                                style: context.textTheme.headlineSmall,
                              ),
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.language.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => controller.onChangeTo(index),
                              tileColor: controller.language[index] ==
                                      controller.toLanguage
                                  ? context.theme.hintColor
                                  : null,
                              leading: CircleAvatar(
                                foregroundImage: AssetImage(
                                    AppAssets.basePathImages +
                                        controller.languageFlag[index]),
                              ),
                              title: Text(
                                controller.language[index],
                                style: context.textTheme.headlineSmall,
                              ),
                            );
                          },
                        ),
                      )
              ],
            ),
          );
        },
      ),
    ));
  }
}
