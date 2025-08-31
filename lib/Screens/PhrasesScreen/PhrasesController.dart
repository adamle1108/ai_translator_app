import 'package:aivoicetranslation/Model/PhrasesModel.dart';
import 'package:aivoicetranslation/constant/ContantData.dart';
import 'package:get/get.dart';

class PhrasesController extends GetxController{
  late PhrasesModel allPhrases;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPhrases();
  }
  getPhrases()
  {
    allPhrases = PhrasesModel.fromJson(phrases);
  }
}