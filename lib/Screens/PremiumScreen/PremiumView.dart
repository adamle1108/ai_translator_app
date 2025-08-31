// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../constant/AppAssets.dart';
// import '../../constant/FontFamily.dart';
// import 'PremiumController.dart';
//
// class PremiumView extends GetView<PremiumController> {
//   const PremiumView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       backgroundColor: context.theme.scaffoldBackgroundColor,
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: Icon(
//                       Icons.close,
//                       color: context.theme.primaryColor,
//                     )),
//               ],
//             ),
//             Image.asset(
//               AppAssets.splashImage,
//               height: 200,
//               width: 200,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color(0x800086ee)),
//               child: ListTile(
//                 title: Text(
//                   'Unlock Unlimited Translation'.tr,
//                   style: TextStyle(
//                       color: context.theme.primaryColor,
//                       fontFamily: poppins,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//                 leading: Image.asset(
//                   AppAssets.splashImage,
//                   height: 30,
//                   width: 30,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color(0x800086ee)),
//               child: ListTile(
//                 title: Text(
//                   'Unlock Unlimited Ai Translation'.tr,
//                   style: TextStyle(
//                       color: context.theme.primaryColor,
//                       fontFamily: poppins,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//                 leading: Image.asset(
//                   AppAssets.splashImage,
//                   height: 25,
//                   width: 25,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color(0x800086ee)),
//               child: ListTile(
//                 leading: Image.asset(
//                   AppAssets.splashImage,
//                   height: 25,
//                   width: 25,
//                 ),
//                 title: Text(
//                   'Unlock Unlimited Scan Picture And Translation'.tr,
//                   style: TextStyle(
//                       color: context.theme.primaryColor,
//                       fontFamily: poppins,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: GetBuilder<PremiumController>(
//                 builder: (controller) {
//                   return ListView.builder(
//                     itemCount: controller.products.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           height: 70,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: controller.selected == index ? 2 : 1,
//                                   color: controller.selected == index
//                                       ? context.theme.focusColor
//                                       : Colors.grey),
//                               color: context.theme.cardColor,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: ListTile(
//                             title: Text(
//                               controller.products[index].title,
//                               style: TextStyle(
//                                   color: context.theme.focusColor,
//                                   fontFamily: poppinsSemiBold,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 18),
//                             ),
//                             subtitle: Text(
//                               controller.products[index].description,
//                               style: TextStyle(
//                                   color: context.theme.focusColor,
//                                   fontFamily: poppins,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14),
//                             ),
//                             trailing: Text(
//                               controller.products[index].price,
//                               style: TextStyle(
//                                   color: context.theme.focusColor,
//                                   fontFamily: poppinsSemiBold,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 18),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             InkWell(
//               onTap: controller.buy,
//               child: Container(
//                 height: 60,
//                 alignment: Alignment.center,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: context.theme.focusColor,
//                     borderRadius: const BorderRadius.all(Radius.circular(15))),
//                 child: Text(
//                   'Continue'.tr,
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: poppins,
//                       fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () => controller.openPrivacy(),
//                   child: Text(
//                     'Privacy Policy'.tr,
//                     style: const TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontFamily: poppins,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   '&',
//                   style: context.textTheme.titleSmall,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 InkWell(
//                   onTap: () => controller.openTerms(),
//                   child: Text(
//                     'Terms & Condition'.tr,
//                     style: const TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14,
//                         fontFamily: poppins,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ));
//   }
// }
import 'package:aivoicetranslation/constant/AppAssets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glossy/glossy.dart';

import '../../constant/FontFamily.dart';
import 'PremiumController.dart';

class PremiumView extends GetView<PremiumController> {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    List type = [
      "Unlock Unlimited Translation",
      "Unlock Unlimited Ai Translation",
      "Unlock Unlimited Scan Picture And Translation",
      "Unlock Unlimited Grammar Correction And Dictionary",
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlossyContainer(
              height: height * 1,
              width: width * 1,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () {
                      Get.back();
                    }, icon: const Icon(Icons.close,color: Colors.white,)),
                    Center(
                      child: Image.asset(
                        AppAssets.splashImage,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Center(child: Text("Unlock Premium",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white,fontFamily: poppins
                    ),)),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        type.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 7, bottom: 7, left: 15),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    type[index],style:const TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white,fontFamily: poppins)
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: GetBuilder<PremiumController>(
                        builder: (controller) {
                          return ListView.builder(
                            itemCount: controller.products.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: controller.selected == index
                                              ? 2
                                              : 1,
                                          color: controller.selected == index
                                              ? context.theme.focusColor
                                              : context.theme.hintColor),
                                      color: context.theme.cardColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    title: Text(
                                      controller.products[index].title,
                                      style: TextStyle(
                                          color: context.theme.focusColor,
                                          fontFamily: poppinsSemiBold,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      controller.products[index].description,
                                      style: TextStyle(
                                          color: context.theme.focusColor,
                                          fontFamily: poppins,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    trailing: Text(
                                      controller.products[index].price,
                                      style: TextStyle(
                                          color: context.theme.focusColor,
                                          fontFamily: poppinsSemiBold,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: context.theme.focusColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Continue',
                          style: context.textTheme.headlineMedium,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => controller.openPrivacy(),
                          child: Text(
                            'Privacy Policy'.tr,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontFamily: poppins,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () => controller.openTerms(),
                          child: Text(
                            'Terms & Condition'.tr,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontFamily: poppins,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
