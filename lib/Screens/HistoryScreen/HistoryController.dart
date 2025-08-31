import 'dart:io';

import 'package:aivoicetranslation/Model/translation.dart';
import 'package:aivoicetranslation/constant/DatabaseHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class HistoryController extends GetxController{
  List<TranslationModel> allTranslation = [];
  List<TranslationModel> allConversation = [];
  ScrollController scrollController = ScrollController();
  late FlutterTts flutterTts;
  bool get isIOS =>  Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;
  final dbHelper = DatabaseHelper();

  String tabTitle = "Translation";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHistory();
    initTts();
  }
  getHistory()
  async {
    allTranslation = await dbHelper.getTranslation();
    allConversation = await dbHelper.getConversation();
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    flutterTts.stop();
    super.onClose();
  }
  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      print("Playing");
      update();
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
    });

    flutterTts.setCancelHandler(() {
      print("Cancel");

    });

    flutterTts.setPauseHandler(() {
      print("Paused");
    });

    flutterTts.setContinueHandler(() {
      print("Continued");
    });

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
    });
  }



  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }
  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,  // Prevent closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Delete History',style: context.textTheme.headlineMedium,),
          content: Text('Are you sure you want to delete all history?',style: context.textTheme.titleSmall,),
          actions: <Widget>[
            TextButton(
              child:  Text('Cancel', style: TextStyle(color:context.theme.primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Perform delete action here
                if (kDebugMode) {
                  print('History deleted');
                }
                dbHelper.deleteAll();
                getHistory();
                Navigator.of(context).pop();  // Close the dialog after action
              },
            ),
          ],
        );
      },
    );
  }

  void scrollToEnd() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    update();
  }
}