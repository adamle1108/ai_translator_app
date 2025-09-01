import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/AppAssets.dart';
import '../../constant/Appkey.dart';
import 'SplashScreenController.dart';


class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: GetBuilder<SplashScreenController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                  width: 200,
                  child: Image.asset(AppAssets.splashImage,fit: BoxFit.fill,)),
            ],
          ),
            const SizedBox(height: 15,),
            Text(appName,style: context.textTheme.headlineLarge,)
          ],);
      },),
    );
  }
}
