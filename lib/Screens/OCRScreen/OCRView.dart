import 'package:aivoicetranslation/Screens/OCRScreen/OCRController.dart';
import 'package:aivoicetranslation/constant/FontFamily.dart';
import 'package:aivoicetranslation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/textfield.dart';

class OCRView extends GetView<OCRController> {
  const OCRView({super.key});

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
          "OCR",
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: GetBuilder<OCRController>(
            builder: (controller) {
              return SingleChildScrollView(

                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
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
                      ),
                      child: Image.file(
                        controller.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
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
                              maxLines: 8,
                              hintText: "Enter Text..",
                              controller: controller.textFieldController,
                              onTap: () {},
                              onChanged: (value) {
                                controller.update();
                              },
                            ),
                            const SizedBox(height: 15,),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.translationScreen,arguments:  {"text" : controller.textFieldController.text});
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: context.theme.focusColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text("Next",
                                    style: TextStyle(
                                        color: context.theme.hintColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: poppinsSemiBold)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    ));
  }
}
