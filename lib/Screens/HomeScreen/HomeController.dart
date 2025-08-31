import 'dart:io';

import 'package:aivoicetranslation/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';


class HomeController extends GetxController{
  final ImagePicker _picker = ImagePicker();
  File? _image;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);

    if (pickedImage != null) {
        _image = File(pickedImage.path);
        final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
        final inputImage = InputImage.fromFile(_image!);
        final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
        String text = recognizedText.text;
        textRecognizer.close();
        Get.toNamed(Routes.oCRView,arguments: {"image" : _image,"text" : text});
    }
  }
}