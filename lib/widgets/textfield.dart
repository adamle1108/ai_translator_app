
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/FontFamily.dart';


class AppTextField extends StatelessWidget {
  TextEditingController? controller;
  VoidCallback? onTap;
  bool? readOnly;
  Widget? suffixIcon;
  String? hintText;
  ScrollController? scrollController;
  ValueChanged<String>? onChanged;
  FocusNode? focusNod;
  int? maxLines = 1;
  late bool autoFocus;

  AppTextField(
      {super.key,
        this.controller,
        this.onTap,
        this.suffixIcon,
        this.autoFocus = false,
        this.onChanged,
        required this.hintText,
        this.maxLines,
        this.readOnly,
        this.scrollController,
        this.focusNod});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollController: scrollController,
      autofocus: autoFocus,
      onTap: () => onTap!(),
      cursorColor: context.theme.primaryColor,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      focusNode:focusNod,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      minLines: 1,
      style: context.textTheme.headlineSmall,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText.toString(),
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
            color: context.theme.shadowColor,
            fontSize: 16,
            fontFamily: poppinsSemiBold,
            fontWeight: FontWeight.bold),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          //// Set border radius here
        ),
      ),
    );
  }
}
