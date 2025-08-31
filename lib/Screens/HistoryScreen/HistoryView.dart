import 'package:aivoicetranslation/Screens/HistoryScreen/ConversationHistoryView.dart';
import 'package:aivoicetranslation/Screens/HistoryScreen/HistoryController.dart';
import 'package:aivoicetranslation/Screens/HistoryScreen/TranslationHistoryView.dart';
import 'package:aivoicetranslation/constant/FontFamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.hintColor,
          title: Text(
            "History",
            style: context.textTheme.headlineMedium,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  controller.showDeleteConfirmationDialog(context);
                },
                child: const Text(
                  "Clear",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ))
          ],
        ),
        body: GetBuilder<HistoryController>(builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.theme.hintColor),
                  child: TabBar(
                      isScrollable: false,
                      dividerColor: Colors.transparent,
                      labelColor: context.theme.primaryColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      padding: const EdgeInsets.all(8),
                      labelStyle: const TextStyle(
                          fontFamily: poppins,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      indicator: BoxDecoration(
                          color: context.theme.focusColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      tabs: [
                        Tab(
                          text: controller.tabTitle,
                        ),
                        Tab(
                          text: 'Conversation'.tr,
                        ),
                      ]),
                ),
              ),
              const Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TranslationHistoryView(),
                      ConversationHistoryView()
                    ]),
              ),
            ],
          );
        },),
      )),
    );
  }
}
