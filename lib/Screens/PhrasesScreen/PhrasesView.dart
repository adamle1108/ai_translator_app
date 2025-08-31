import 'package:aivoicetranslation/routes/app_routes.dart';
import 'PhrasesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhrasesView extends GetView<PhrasesController> {
  const PhrasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
          child: GetBuilder<PhrasesController>(
            builder: (controller) {
              return ListView.builder(
                itemCount: controller.allPhrases.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(Icons.arrow_forward,color: context.theme.shadowColor,),
                    onTap: () {
                      Get.toNamed(Routes.subPhrasesView,arguments: {"index" : index});
                    },
                    title: Text(controller.allPhrases.data![index].title!),
                  );
                },
              );
            },
          )),
    ));
  }
}
