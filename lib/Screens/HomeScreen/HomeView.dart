import 'package:aivoicetranslation/constant/Appkey.dart';
import 'package:aivoicetranslation/constant/FontFamily.dart';
import 'package:aivoicetranslation/routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../PremiumScreen/PremiumController.dart';
import 'HomeController.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.hintColor,
          title: Text(
            'AI Translator',
            style: context.textTheme.headlineMedium,
          ).tr(),
          actions: [
            if (Get.find<PremiumController>().isPremium == false)
              GestureDetector(
                onTap: () => showChatLimitDialog(context),
                child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.focusColor),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "$freeLimit",
                        style: TextStyle(
                            fontFamily: poppins,
                            color: context.theme.hintColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.historyView);
                },
                icon: Icon(
                  Icons.history,
                  color: context.theme.primaryColor,
                )),
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.settingView);
                },
                icon: Icon(
                  Icons.settings,
                  color: context.theme.primaryColor,
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // TextField rộng + cao, luôn viền xám
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        readOnly: true,
                        maxLines: 5, // 👈 chỉnh số dòng để tăng chiều cao
                        decoration: InputDecoration(
                          hintText: tr("Enter Text"),
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(12),

                          // viền mặc định
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          // viền khi enabled
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          // viền khi focus (không đổi màu)
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.toNamed(Routes.translationScreen);
                        },
                      ),
                    ),

                    Positioned(
                      left: 12,
                      bottom: 12,
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.translationScreen),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.translate, size: 20),
                            const SizedBox(width: 6),
                            Text("Translate Expert").tr(), // dùng Obx để update
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Ai Translation",
                  style: context.textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.aiTranslationView);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffc200ee)),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.hintColor),
                        child: const Icon(
                          Icons.message,
                          color: Color(0xffc200ee),
                          size: 35,
                        ),
                      ),
                      title: Text(
                        "AI Translation",
                        style: TextStyle(
                            color: context.theme.hintColor,
                            fontSize: 18,
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "I can help you with the correct translation",
                        style: TextStyle(
                            color: context.theme.scaffoldBackgroundColor,
                            fontSize: 14,
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.grammarView),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff24a801)),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.hintColor),
                        child: const Icon(
                          Icons.my_library_books_sharp,
                          color: Color(0xff24a801),
                          size: 30,
                        ),
                      ),
                      title: Text(
                        "Grammar Correction",
                        style: TextStyle(
                            color: context.theme.hintColor,
                            fontSize: 18,
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Enhancing Clarity and Precision in Writing",
                        style: TextStyle(
                            color: context.theme.scaffoldBackgroundColor,
                            fontSize: 14,
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showChatLimitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          title: Text(
            'Translation Limited',
            style: context.textTheme.headlineMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Translation available: $freeLimit',
                style: context.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Users get free 10 Translation for one time',
                style: context.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Upgrade to premium for unlimited Translation,Voice translation,Image text translation,Phrases translation and Grammar translation',
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Close',
                style: TextStyle(color: context.theme.focusColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
