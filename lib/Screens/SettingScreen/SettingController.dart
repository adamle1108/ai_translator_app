import 'dart:io';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../constant/Appkey.dart';

class SettingController extends GetxController{
  final InAppReview inAppReview = InAppReview.instance;

  showRateUs() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }

  }
  shareApps()
  {
    if(Platform.isAndroid)
    {
      Share.share(shareAppsAndroid);
    }else{
      Share.share(shareAppsIOS);
    }
  }
  openPrivacy()
  async {
    final Uri url = Uri.parse(privacyLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  openTerms()
  async {
    final Uri url = Uri.parse(termsLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}