import 'package:aivoicetranslation/constant/FontFamily.dart';
import 'package:aivoicetranslation/routes/app_routes.dart';

import 'SubPhrasesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubPhrasesView extends GetView<SubPhrasesController> {
  const SubPhrasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.hintColor,
        title: Text(
          "Phrases",
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GetBuilder<SubPhrasesController>(
          builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.phrasesModel
                        .data![controller.selectedIndex].subdata!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.onChangeCategory(index);

                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: controller.categoryIndex == index
                                  ? context.theme.focusColor
                                  : context.theme.hintColor,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: context.theme.focusColor)),
                          child: Text(
                            controller
                                .phrasesModel
                                .data![controller.selectedIndex]
                                .subdata![index]
                                .title!,
                            style: TextStyle(
                                color: controller.categoryIndex == index
                                    ? context.theme.hintColor
                                    : context.theme.primaryColor,
                                fontFamily: poppinsSemiBold,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: controller
                      .phrasesModel
                      .data![controller.selectedIndex]
                      .subdata![controller.categoryIndex]
                      .subData!
                      .length,
                  itemBuilder: (context, index) {
                    return  ListTile(
                      onTap: () {
                        Get.toNamed(Routes.translationScreen,arguments: {"text" :  controller
                            .phrasesModel
                            .data![controller.selectedIndex]
                            .subdata![controller.categoryIndex]
                            .subData![index]});
                      },
                      title: Text(
                        controller
                            .phrasesModel
                            .data![controller.selectedIndex]
                            .subdata![controller.categoryIndex]
                            .subData![index],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleSmall,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                    );
                  },
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}
