import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:aivoicetranslation/Model/DicionaryModel.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController{
  TextEditingController textController = TextEditingController();
  bool inProgress = false;
  DictionaryModel? responseModel;
  String noDataText = "Welcome, Start searching";


  static const String baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  Future fetchMeaning(String word) async {
    print("Hello api calling");
    inProgress = true;
    update();
   try{
     final response = await http.get(Uri.parse("$baseUrl$word"));
     if (response.statusCode == 200) {
       final data = json.decode(response.body);
       responseModel =  DictionaryModel.fromJson(data[0]);
       inProgress = false;
       update();
     } else {
       throw Exception("failed to load meaning");
     }
   }catch(e)
    {
      print(e);
      responseModel = null;
      noDataText = "Meaning cannot be fetched";
      inProgress = false;

      update();
    }
  }
}