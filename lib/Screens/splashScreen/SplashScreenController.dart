
import 'package:aivoicetranslation/constant/Appkey.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../SharePrefHelper/SharePref.dart';
import '../../SharePrefHelper/SharePrefKey.dart';
import '../../routes/app_routes.dart';


class SplashScreenController extends GetxController{
  bool notificationsEnabled = false;
  @override
  void onInit() {
    // TODO: implement onInit
    navigation();
    getLimits();
    super.onInit();
  }
  navigation()
  {
    Future.delayed(const Duration(seconds: 3),() {
      Get.offAllNamed(Routes.tabbarScreen);
    },);
  }


  getLimits() async {
    freeLimit = await SharedPref.readInt(SharePrefKey.freeLimit) ?? freeLimit;
    if (kDebugMode) {
      print("FreeLimit === > $freeLimit");
    }
    update();
  }



}