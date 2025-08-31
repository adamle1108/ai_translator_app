import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OCRController extends GetxController{
  TextEditingController textFieldController = TextEditingController();
  Map<String,dynamic> argument  = Get.arguments;
  late File image;
  String text="";

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    image = argument['image'];
    textFieldController.text= argument['text'];
    update();
  }
}