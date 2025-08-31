import 'package:flutter/material.dart';

import '../constant/FontFamily.dart';

class AppTheme {

  static final dark = ThemeData.dark().copyWith(
      scaffoldBackgroundColor:  const Color(0xff151515),
      primaryColor: Colors.white,
      focusColor: const Color(0xff0086ee),
      cardColor:  Colors.black,
      hintColor: Colors.black,
      hoverColor: Colors.black,
      shadowColor: Colors.grey,
      highlightColor: Colors.white,
      textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Colors.white,fontSize: 16,fontFamily: poppinsSemiBold,fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: Colors.white,fontFamily: poppins,fontWeight: FontWeight.w500,fontSize: 16),
          titleMedium:TextStyle(color: Colors.black),
          headlineMedium: TextStyle(color: Colors.white,fontSize: 20,fontFamily: poppinsSemiBold,fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(color: Colors.white,fontSize: 22,fontFamily: poppins,fontWeight: FontWeight.bold),
          bodySmall: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500,fontFamily: poppinsSemiBold)
      ));

  static final light = ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color(0xfffbfafa),
      primaryColor: const Color(0xff181a20),
      focusColor: const Color(0xff0086ee),
      hintColor: Colors.white,
      shadowColor: Colors.grey,
      cardColor: const Color(0xfff6f6f6),
      highlightColor: Colors.black,
      hoverColor: Colors.grey,
      textTheme: const TextTheme(
          titleSmall: TextStyle(color: Colors.black,fontFamily: poppins,fontWeight: FontWeight.w500,fontSize: 16),
          titleMedium:  TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.black,fontSize: 16,fontFamily: poppinsSemiBold,fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(color: Colors.black,fontSize: 20,fontFamily: poppinsSemiBold,fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(color: Colors.black,fontSize: 22,fontFamily: poppins,fontWeight: FontWeight.bold),
          bodySmall: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,fontFamily: poppinsSemiBold)
      ));
}
