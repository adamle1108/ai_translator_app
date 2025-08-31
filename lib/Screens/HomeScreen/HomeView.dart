import 'package:aivoicetranslation/constant/AppAssets.dart';
import 'package:aivoicetranslation/constant/Appkey.dart';
import 'package:aivoicetranslation/constant/FontFamily.dart';
import 'package:aivoicetranslation/routes/app_routes.dart';
import 'package:aivoicetranslation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../PremiumScreen/PremiumController.dart';
import 'HomeController.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
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
            'AI Voice Translation',
            style: context.textTheme.headlineMedium,
          ),
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
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: context.theme.hintColor,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        AppTextField(
                          readOnly: true,
                          hintText: "Enter Text..",
                          onTap: () {
                            Get.toNamed(Routes.translationScreen);
                          },
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                showImagePickerOptions(context);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    color: context.theme.primaryColor,
                                    size: 30,
                                  ),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: poppins,
                                        fontWeight: FontWeight.bold,
                                        color: context.theme.primaryColor),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.conversationView);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.mic,
                                    color: context.theme.primaryColor,
                                    size: 30,
                                  ),
                                  Text(
                                    "Voice",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: poppins,
                                        fontWeight: FontWeight.bold,
                                        color: context.theme.primaryColor),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
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
                  onTap: () {
                    Get.toNamed(Routes.conversationView);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff0086ee)),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.hintColor),
                        child: const Icon(
                          Icons.mic,
                          color: Color(0xff0086ee),
                          size: 40,
                        ),
                      ),
                      title: Text(
                        "Voice Conversation",
                        style: TextStyle(
                            color: context.theme.hintColor,
                            fontSize: 18,
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Conversations in Motion: Expressing Through Voice",
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
                  onTap: () => showImagePickerOptions(context),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff853cea)),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.hintColor),
                        child: const Icon(
                          Icons.language,
                          color: Color(0xff853cea),
                          size: 30,
                        ),
                      ),
                      title: Text(
                        "OCR Translator",
                        style: TextStyle(
                            color: context.theme.hintColor,
                            fontSize: 18,
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Bringing Words to Life: Translating Text from Images",
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
                  onTap: () {
                    Get.toNamed(Routes.phrasesView);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xfff07300)),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.hintColor),
                        child: const Icon(
                          Icons.my_library_books,
                          color: Color(0xfff07300),
                          size: 30,
                        ),
                      ),
                      title: Text(
                        "phrases",
                        style: TextStyle(
                            color: context.theme.hintColor,
                            fontSize: 18,
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Turning Words into Bridges: Seamless Phrase Translation",
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
                  onTap: () => Get.toNamed(Routes.dictionaryView),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffed4153)),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.hintColor),
                        child: const Icon(
                          Icons.my_library_books_sharp,
                          color: Color(0xffed4153),
                          size: 30,
                        ),
                      ),
                      title: Text(
                        "Dictionary",
                        style: TextStyle(
                            color: context.theme.hintColor,
                            fontSize: 18,
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Unlocking Words: Your Guide to Meaning",
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

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: context.theme.hintColor,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: context.theme.primaryColor,
                ),
                title: Text(
                  'Camera',
                  style: context.textTheme.headlineSmall,
                ),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: context.theme.primaryColor,
                ),
                title: Text(
                  'Gallery',
                  style: context.textTheme.headlineSmall,
                ),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
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
