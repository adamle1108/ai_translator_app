import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../SharePrefHelper/SharePref.dart';
import '../../SharePrefHelper/SharePrefKey.dart';
import '../../constant/Appkey.dart';
import '../../routes/app_routes.dart';

class PremiumController extends GetxController {
  int selected = 0;
  bool isPremium = false;
  InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<dynamic> streamSubscription;
  Set<String> ids = Platform.isAndroid
      ? {androidInAppPurchaseIdWeekly, androidInAppPurchaseIdYearly}
      : {iOSInAppPurchaseIdWeekly, iOSInAppPurchaseIdYearly};
  List<ProductDetails> products = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPremium();
    Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;

    streamSubscription = purchaseUpdated.listen(
          (purchaseList) {
        listenToPurchase(purchaseList);
      },
      onDone: () {
        streamSubscription.cancel();
      },
      onError: (error) {
        Fluttertoast.showToast(
          msg: "some thing went wrong",
        );
      },
    );
    initStore();
  }

  initStore() async {
    final bool isAvailable = await InAppPurchase.instance.isAvailable();
    ProductDetailsResponse productDetailsResponse = await inAppPurchase.queryProductDetails(ids);
    if (productDetailsResponse.error == null) {
      if (kDebugMode) {
        print("loading Product$productDetailsResponse");
        print(productDetailsResponse.error);
        print(productDetailsResponse.notFoundIDs);
        print(productDetailsResponse.productDetails.length);
      }
      products = productDetailsResponse.productDetails;
      update();
    }
  }

  listenToPurchase(List<PurchaseDetails> purchaseDetailsList) {
    for (var element in purchaseDetailsList) {
      if (element.status == PurchaseStatus.pending) {
        Fluttertoast.showToast(msg: "pending");
      } else if (element.status == PurchaseStatus.error) {
        Fluttertoast.showToast(msg: "Something went wrong",);
      } else if (element.status == PurchaseStatus.restored) {
        Fluttertoast.showToast(msg: "Restored");
        DateTime? purchaseDate = element.transactionDate != null
            ? DateTime.fromMillisecondsSinceEpoch(
            int.parse(element.transactionDate!))
            : null;
        if (purchaseDate != null) {
          // Store the purchase date
          storeDate(purchaseDate.toString());
        }
      } else if (element.status == PurchaseStatus.purchased) {
        Fluttertoast.showToast(
          msg: "purchased",
        );
      }
    }
  }

  buy() {
    DateTime date = DateTime.now();
    DateTime weekLater = DateTime(date.year, date.month, date.day + 7);
    DateTime yearLater = DateTime(date.year + 1, date.month, date.day);
    try {
      if (products.isNotEmpty) {
        final PurchaseParam param =
        PurchaseParam(productDetails: products[selected]);
        inAppPurchase.buyNonConsumable(purchaseParam: param);
        InAppPurchase.instance.purchaseStream.listen(
              (event) {
            for (var element in event) {
              if (element.status == PurchaseStatus.purchased) {
                if (Platform.isIOS) {
                  if (element.productID == iOSInAppPurchaseIdWeekly) {
                    storeDate(weekLater.toString());
                  } else if (element.productID == iOSInAppPurchaseIdYearly) {
                    storeDate(yearLater.toString());
                  }
                } else {
                  if (element.productID == androidInAppPurchaseIdWeekly) {
                    storeDate(weekLater.toString());
                  } else if (element.productID ==
                      androidInAppPurchaseIdYearly) {
                    storeDate(yearLater.toString());
                  }
                }
              } else if (element.status == PurchaseStatus.canceled) {
                Fluttertoast.showToast(
                  msg: "Something went wrong",
                );
              }
            }
          },
        );
      } else {
        Fluttertoast.showToast(
          msg: "No products available for purchase",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("error ==> $e");
      }
    }
  }

  storeDate(String dateTime) async {
    // await sharePrefService.addStringToSF(key: 'Premium_Date', value: dateTime);
    await SharedPref.saveString(SharePrefKey.premiumDate, dateTime);
    await SharedPref.saveBool(SharePrefKey.isPremium, true);
    isPremium = true;
    update();
    Get.toNamed(Routes.homeScreen);
  }

  getDate() async {
    String premiumDate = await SharedPref.readString(SharePrefKey.premiumDate);
    if (premiumDate.isNotEmpty) {
      DateTime fin = DateTime.parse(premiumDate);
      DateTime date = DateTime.now();
      DateTime time = DateTime(date.year, date.month, date.day);
      if (premiumDate != "") {
        if (time.compareTo(fin) < 0) {
          isPremium = true;
          update();
        } else {
          isPremium = false;
          update();
        }
      }
    }
  }

  getPremium() async {
    isPremium = await SharedPref.readBool(SharePrefKey.isPremium) ?? false;
    update();
    if (isPremium) {
      getDate();
    }

  }

  openPrivacy() async {
    final Uri url = Uri.parse(privacyLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  openTerms() async {
    final Uri url = Uri.parse(termsLink);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
