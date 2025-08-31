import 'package:aivoicetranslation/Screens/SelectLanguage/SelectLanguageController.dart';
import 'package:aivoicetranslation/constant/AppAssets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../constant/FontFamily.dart';
import '../../routes/app_routes.dart';
import '../../widgets/textfield.dart';
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
          title: Text("Trình dịch", style: context.textTheme.titleLarge),
          centerTitle: false,
          actions: [
            IconButton(icon: const Icon(Icons.star_border), onPressed: () {/* lưu yêu thích */}),
            IconButton(icon: const Icon(Icons.share), onPressed: () {/* share */}),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {/* thêm nhanh ghi chú/dịch mới */},
          child: const Icon(Icons.add),
        ),
        body: GetBuilder<TranslationController>(
          builder: (c) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ====== Thanh chọn ngôn ngữ ======
                  Row(
                    children: [
                      Expanded(child: _LangPill(text: c.fromLanguage, onTap: () async {
                        final result = await Get.toNamed(
                          Routes.selectLanguageView,
                          arguments: {
                            "fromLanguage": c.fromLanguage,
                            "toLanguage": c.toLanguage,
                            "selectedFrom": true
                          },
                        );
                        if (result != null) c.onChangeLanguage(result);
                      })),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: c.swapLanguage,
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(
                            color: context.theme.cardColor,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.05),
                            )],
                          ),
                          child: const Center(child: Icon(Icons.swap_horiz)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: _LangPill(text: c.toLanguage, onTap: () async {
                        final result = await Get.toNamed(
                          Routes.selectLanguageView,
                          arguments: {
                            "fromLanguage": c.fromLanguage,
                            "toLanguage": c.toLanguage,
                            "selectedFrom": false
                          },
                        );
                        if (result != null) c.onChangeLanguage(result);
                      })),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // ====== Ô nhập (nguồn) ======
                  Text(
                    c.fromLanguage,
                    style: context.textTheme.labelLarge?.copyWith(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TextField
                        Expanded(
                          child: TextField(
                            controller: c.textFieldController,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: "Nhập văn bản",
                              border: InputBorder.none,
                            ),
                            onChanged: (_) => c.update(),
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Action icons: loa, copy, xóa
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
                                Clipboard.setData(ClipboardData(text: c.textFieldController.text));
                                Get.snackbar("Đã sao chép", "Đoạn văn bản nguồn",
                                    snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(12));
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
                  ),

                  const SizedBox(height: 6),
                  Text(
                    "${c.textFieldController.text.characters.length}/${c.maxChars}",
                    style: context.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 16),

                  // ====== Nút Dịch ======
                  if (c.textFieldController.text.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => c.translationText(c.textFieldController.text),
                        child: const Text("Dịch", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // ====== Loading ======
                  if (c.isLoading) const Center(child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: CircularProgressIndicator(),
                  )),

                  // ====== KẾT QUẢ ======
                  if (!c.isLoading && c.correctionAiResponse.isNotEmpty) ...[
                    Text(
                      c.toLanguage,
                      style: context.textTheme.labelLarge?.copyWith(color: Colors.grey[700]),
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
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Phiên âm (có thể bật/tắt)
                          if (c.showPhonetic)
                            Text(
                              "/həˈloʊ wɜːrld/",
                              style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
                            ),

                          const SizedBox(height: 12),

                          // Giải thích
                          Text(
                            "Một cụm từ thường được sử dụng trong lập trình để minh họa cú pháp cơ bản.",
                            style: context.textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 12),

                          // Hàng icon bên phải: mở rộng, loa, sao chép
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
                                  Clipboard.setData(ClipboardData(text: c.correctionAiResponse));
                                  Get.snackbar("Đã sao chép", "Bản dịch",
                                      snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(12));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ====== Hàng tùy chọn cuối (dropdown + toggle phiên âm) ======
                    Row(
                      children: [
                        // Dropdown "Translate Expert"
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: c.expertMode,
                              items: c.expertModes.map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              )).toList(),
                              onChanged: (v) { if (v != null) c.changeExpert(v); },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Nút “Hiển thị phiên âm”
                        OutlinedButton.icon(
                          onPressed: c.togglePhonetic,
                          icon: const Icon(Icons.auto_fix_high),
                          label: Text(c.showPhonetic ? "Ẩn phiên âm" : "Hiển thị phiên âm"),
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Pill ngôn ngữ giống ảnh
class _LangPill extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _LangPill({required this.text, required this.onTap, Key? key}) : super(key: key);

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