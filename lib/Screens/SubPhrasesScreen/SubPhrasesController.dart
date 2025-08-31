import 'package:aivoicetranslation/Model/PhrasesModel.dart';
import 'package:aivoicetranslation/constant/ContantData.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:get/get.dart';
import '../../constant/Appkey.dart';

class SubPhrasesController extends GetxController{
  Map<String,dynamic> argument = Get.arguments;
  late PhrasesModel phrasesModel;
  String fromLanguage = "English";
  String toLanguage = "Hindi";
  String toLanguageCode = "hi-IN";
  int selectedIndex = 0;
  int categoryIndex = 0;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedIndex = argument['index'];
    phrasesModel = PhrasesModel.fromJson(phrases);
    OpenAI.apiKey = apiKey;
    update();
  }
  onChangeCategory(int index)
  {
    categoryIndex = index;
    update();
  }
}