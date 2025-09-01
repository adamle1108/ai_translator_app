import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_routes.dart';
import 'TranslationController.dart';

class TranslationView extends GetView<TranslationController> {
  const TranslationView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          title: Text(
            "Trình dịch",
            style: context.textTheme.headlineMedium,
          ),
          centerTitle: false,
        ),
        body: GetBuilder<TranslationController>(
          builder: (c) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ====== Thanh chọn ngôn ngữ ======
                      Row(
                        children: [
                          Expanded(
                            child: _LangPill(
                              text: c.fromLanguage,
                              onTap: () async {
                                final result = await Get.toNamed(
                                  Routes.selectLanguageView,
                                  arguments: {
                                    "fromLanguage": c.fromLanguage,
                                    "toLanguage": c.toLanguage,
                                    "selectedFrom": true,
                                  },
                                );
                                if (result != null) c.onChangeLanguage(result);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: c.swapLanguage,
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: context.theme.cardColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    color: Colors.black.withOpacity(0.05),
                                  )
                                ],
                              ),
                              child:
                                  const Center(child: Icon(Icons.swap_horiz)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _LangPill(
                              text: c.toLanguage,
                              onTap: () async {
                                final result = await Get.toNamed(
                                  Routes.selectLanguageView,
                                  arguments: {
                                    "fromLanguage": c.fromLanguage,
                                    "toLanguage": c.toLanguage,
                                    "selectedFrom": false,
                                  },
                                );
                                if (result != null) c.onChangeLanguage(result);
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // ====== Ô nhập (nguồn) ======
                      Text(
                        c.fromLanguage,
                        style: context.textTheme.labelLarge
                            ?.copyWith(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 8),

                      Stack(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                controller: c.textFieldController,
                                maxLines: 10,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter Text..",
                                  alignLabelWithHint: true,
                                  // 👇 chỉnh padding riêng
                                  contentPadding: const EdgeInsets.only(
                                    left: 8, // padding trái
                                    bottom: 40, // padding dưới
                                    right: 40, // padding phải
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                ),
                                onChanged: (_) => c.update(),
                              )),

                          if (c.textFieldController.text.isNotEmpty) ...[
                            Positioned(
                              left: 8,
                              bottom: 4,
                              child: Text(
                                "${c.textFieldController.text.characters.length}/${c.maxChars}",
                                style: context.textTheme.labelSmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ),
                          ],

                          // ===== Overlay khi chưa nhập text =====
                          if (c.textFieldController.text.isEmpty) ...[
                            Positioned(
                              left: 12,
                              bottom: 12,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: () =>
                                      _showModelBottomSheet(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor:
                                        Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.translate, size: 20),
                                      const SizedBox(width: 6),
                                      Text(c.selectedModel.value),
                                      const Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 12,
                              bottom: 12,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        showImagePickerOptions(context),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.camera_alt,
                                            color: context.theme.primaryColor,
                                            size: 28),
                                        Text(
                                          "Camera",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: context.theme.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(Routes.conversationView),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.mic,
                                            color: context.theme.primaryColor,
                                            size: 28),
                                        Text(
                                          "Voice",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: context.theme.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(),

                              // Chỉ hiển thị nếu có text
                              if (c.textFieldController.text.isNotEmpty)
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.volume_up),
                                      tooltip: "Đọc",
                                      onPressed: c.speakSource,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.copy_all_outlined),
                                      tooltip: "Sao chép",
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(
                                            text: c.textFieldController.text));
                                        Get.snackbar(
                                            "Đã sao chép", "Đoạn văn bản nguồn",
                                            snackPosition: SnackPosition.BOTTOM,
                                            margin: const EdgeInsets.all(12));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      tooltip: "Xóa",
                                      onPressed: c.clearInput,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ====== Nút Dịch ======
                      if (c.textFieldController.text.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () =>
                                c.translationText(c.textFieldController.text),
                            child: const Text(
                              "Dịch",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),

                      // ====== Loading ======
                      if (c.isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: CircularProgressIndicator(),
                          ),
                        ),

                      // ====== KẾT QUẢ ======
                      if (!c.isLoading &&
                          c.correctionAiResponse.isNotEmpty) ...[
                        Text(
                          c.toLanguage,
                          style: context.textTheme.labelLarge
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: width,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: context.theme.cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dòng tiêu đề kết quả (xanh)
                              SelectableText(
                                c.correctionAiResponse,
                                style:
                                    context.textTheme.headlineSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Hàng icon bên phải
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    tooltip: "Mở rộng",
                                    icon: const Icon(Icons.open_in_full),
                                    onPressed: () {/* mở trang chi tiết */},
                                  ),
                                  IconButton(
                                    tooltip: "Đọc bản dịch",
                                    icon: const Icon(Icons.volume_up),
                                    onPressed: c.speakTarget,
                                  ),
                                  IconButton(
                                    tooltip: "Sao chép bản dịch",
                                    icon: const Icon(Icons.copy_all_outlined),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: c.correctionAiResponse));
                                      Get.snackbar("Đã sao chép", "Bản dịch",
                                          snackPosition: SnackPosition.BOTTOM,
                                          margin: const EdgeInsets.all(12));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Choose GPT Model",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              RadioListTile<String>(
                title: const Text("GPT-4o"),
                subtitle:
                    const Text("Most advanced, context-aware translations."),
                value: "GPT-4o",
                groupValue: controller.selectedModel.value,
                onChanged: (value) {
                  controller.selectedModel.value = value!;
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text("GPT-4o Mini"),
                subtitle: const Text("Fast and efficient with high accuracy."),
                value: "GPT-4o Mini",
                groupValue: controller.selectedModel.value,
                onChanged: (value) {
                  controller.selectedModel.value = value!;
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: const Text("Translate Expert"),
                subtitle: const Text("Default and normal"),
                value: "Translate Expert",
                groupValue: controller.selectedModel.value,
                onChanged: (value) {
                  controller.selectedModel.value = value!;
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
      },
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
}

/// Pill ngôn ngữ
class _LangPill extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _LangPill({required this.text, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: const StadiumBorder(),
        side: BorderSide(color: Colors.grey.shade300),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
