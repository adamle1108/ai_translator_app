import 'package:aivoicetranslation/Screens/HomeScreen/HomeView.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class MainView extends GetView<MainController> {
  const MainView({super.key});

  final List<Widget> pages = const [
    HomeView(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {"icon": Icons.translate, "label": "Translator"},
      {"icon": Icons.menu_book, "label": "Dictionary"},
      {"icon": Icons.format_quote, "label": "Phrase"},
      {"icon": Icons.people, "label": "Conversation"},
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        floatingActionButton: Transform.translate(
          offset: const Offset(0, 10), // lùi xuống dưới
          child: SizedBox(
            width: 70, // đường kính vòng tròn lớn hơn, mặc định ~56
            height: 70,
            child: FloatingActionButton(
              heroTag: "mainFab",
              onPressed: () {
                Get.snackbar("Voice", "Microphone pressed!");
              },
              shape: const CircleBorder(),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.mic,
                  size: 35, color: Colors.white), // tăng icon cho cân
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white, // màu nền BottomAppBar
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12, // màu bóng mờ
                blurRadius: 6, // độ mờ/soft của bóng
                offset: const Offset(0, -2), // bóng hơi dơ xuống trên
              ),
            ],
          ),
          child: BottomAppBar(
            color: Colors.transparent, // giữ trong suốt để hiện màu Container
            notchMargin: 8,
            elevation: 0,
            child: Row(
              children: [
                // Tab trái
                Expanded(
                  child: Row(
                    children: List.generate(2, (index) {
                      return _buildTabItem(
                        icon: tabs[index]["icon"] as IconData,
                        label: tabs[index]["label"] as String,
                        index: index,
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 50), // chừa chỗ cho mic
                // Tab phải
                Expanded(
                  child: Row(
                    children: List.generate(2, (index) {
                      final i = index + 2;
                      return _buildTabItem(
                        icon: tabs[i]["icon"] as IconData,
                        label: tabs[i]["label"] as String,
                        index: i,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          if (index == 0) {
            // index 0 vẫn dùng IndexedStack
            controller.changeTab(0);
          } else {
            // các tab còn lại push màn mới
            String page;
            switch (index) {
              case 1:
                page = Routes.dictionaryView;
                break;
              case 2:
                page = Routes.phrasesView;
                break;
              case 3:
                page = Routes.conversationView;
                break;
              default:
                page = Routes.homeScreen;
            }
            Get.toNamed(page);
          }
        },
        child: SizedBox(
          height: 56,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: controller.currentIndex.value == index
                    ? Colors.blue
                    : Colors.grey,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: controller.currentIndex.value == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: controller.currentIndex.value == index
                      ? Colors.blue
                      : Colors.grey,
                ),
              ).tr(),
            ],
          ),
        ),
      ),
    );
  }
}
