import 'package:aivoicetranslation/constant/FontFamily.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restart_app/restart_app.dart';

import '../../ThemeService/ThemeController.dart';
import '../../routes/app_routes.dart';
import '../PremiumScreen/PremiumController.dart';
import 'SettingController.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.hintColor,
        title: Text(
          "Setting",
          style: context.textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            if (Get.find<PremiumController>().isPremium == false)
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 15, left: 10, right: 10),
                width: width,
                decoration: BoxDecoration(
                    color: context.theme.highlightColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () => Get.toNamed(Routes.premiumView),
                  leading: Icon(
                    Icons.mail,
                    color: context.theme.focusColor,
                    size: 35,
                  ),
                  title: Text(
                    "Upgrade Premium",
                    style: TextStyle(
                        color: context.theme.cardColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: poppins,
                        fontSize: width * 0.04),
                  ),
                  subtitle: Text(
                    "Tap to upgrade your account",
                    style: TextStyle(
                        color: context.theme.hoverColor,
                        fontWeight: FontWeight.normal,
                        fontFamily: poppins,
                        fontSize: width * 0.035),
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => showLanguageBottomSheet(context),
              child: Container(
                decoration: BoxDecoration(
                    color: context.theme.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(
                    Icons.language,
                    color: context.theme.primaryColor,
                  ),
                  title: Text(
                    "Language",
                    style: TextStyle(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: poppins,
                        fontSize: 18),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 20,
                    color: context.theme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => showThemeDialog(context),
              child: Container(
                decoration: BoxDecoration(
                    color: context.theme.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                    leading: Icon(
                      Icons.light_mode,
                      color: context.theme.primaryColor,
                    ),
                    title: Text(
                      'Day & Night Mode',
                      style: TextStyle(
                          color: context.theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: poppins,
                          fontSize: 18),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
                      color: context.theme.primaryColor,
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => controller.showRateUs(),
              child: Container(
                decoration: BoxDecoration(
                    color: context.theme.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    color: context.theme.primaryColor,
                  ),
                  title: Text(
                    "Rate us",
                    style: TextStyle(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: poppins,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => controller.shareApps(),
              child: Container(
                decoration: BoxDecoration(
                    color: context.theme.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(
                    Icons.share,
                    color: context.theme.primaryColor,
                  ),
                  title: Text(
                    "Share app",
                    style: TextStyle(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: poppins,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => controller.openPrivacy(),
              child: Container(
                decoration: BoxDecoration(
                    color: context.theme.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(
                    Icons.privacy_tip_sharp,
                    color: context.theme.primaryColor,
                  ),
                  title: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: poppins,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => controller.openTerms(),
              child: Container(
                decoration: BoxDecoration(
                    color: context.theme.hintColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(
                    Icons.privacy_tip,
                    color: context.theme.primaryColor,
                  ),
                  title: Text(
                    "Term of Condition",
                    style: TextStyle(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: poppins,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }

  void showThemeDialog(BuildContext context) {
    Get.defaultDialog(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      title: 'Day & Night Mode',
      contentPadding: const EdgeInsets.all(8),
      content: GetBuilder<ThemeController>(
        builder: (controller) {
          return Column(
            children: [
              CheckboxListTile(
                activeColor: context.theme.focusColor,
                value: controller.isDayMode,
                hoverColor: context.theme.hoverColor,
                onChanged: (value) {
                  controller.seThemeMode(false);
                  Get.back();
                },
                title: Text(
                  'Day Mode',
                  style: TextStyle(color: context.theme.primaryColor),
                ),
              ),
              CheckboxListTile(
                activeColor: context.theme.focusColor,
                hoverColor: context.theme.hoverColor,
                value: controller.isNightMode,
                onChanged: (value) {
                  controller.seThemeMode(true);
                  Get.back();
                },
                title: Text(
                  'Night Mode',
                  style: TextStyle(color: context.theme.primaryColor),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    final box = GetStorage();
    String currentLang = box.read('language') ?? 'en';

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.language,
                color: context.theme.primaryColor,
              ),
              title: const Text("English"),
              trailing: currentLang == 'en'
                  ? Icon(Icons.check,
                      color: context.theme.primaryColor) // ✅ selected
                  : null,
              onTap: () {
                box.write('language', 'en');
                Restart.restartApp(
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: context.theme.primaryColor,
              ),
              title: const Text("Tiếng Việt"),
              trailing: currentLang == 'vi'
                  ? Icon(Icons.check,
                      color: context.theme.primaryColor) // ✅ selected
                  : null,
              onTap: () {
                box.write('language', 'vi');
                Get.back();
                Restart.restartApp(
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
