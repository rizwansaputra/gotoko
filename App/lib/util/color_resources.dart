import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorResources {

  static Color getRedColor() {
    return Get.isDarkMode ? const Color(0xFFbd0a00) : const Color(0xFFFF4848);
  }
  static Color getSplashColor1() {
    return Get.isDarkMode ? const Color(0xFFCC003F).withOpacity(.15) : const Color(0xFFCC003F).withOpacity(.15);
  }
  static Color getTextColor() {
    return Get.isDarkMode ? const Color(0xFFE4E8EC) : const Color(0xFF25282B);
  }

  static Color getTitleColor() {
    return Get.isDarkMode ? const Color(0xFFE4E8EC) : const Color(0xFF003473);
  }

  static Color getCheckoutTextColor() {
    return Get.isDarkMode ? const Color(0xFFE4E8EC) : const Color(0xFF4C5D70);
  }

  static Color getCategoryWithProductColor() {
    return Get.isDarkMode ? const Color(0xFF989797) : const Color(0xFFBDC1C4);
  }

  static Color getIconBg() {
    return Get.isDarkMode ? const Color(0xFF2e2e2e) : const Color(0xFFF9F9F9);
  }



  static Color getSplashColor2() {
    return Get.isDarkMode ? const Color(0xFF003473).withOpacity(.15) : const Color(0xFF003473).withOpacity(.15);
  }
  static Color revenueCardOneColor() {
    return Get.isDarkMode ? const Color(0xFF286FC6) : const Color(0xFF286FC6);
  }
  static Color revenueCardTwoColor() {
    return Get.isDarkMode ? const Color(0xFF5ABD88)  : const Color(0xFF5ABD88);
  }
  static Color revenueCardOThreeColor() {
    return Get.isDarkMode ? const Color(0xFFD0517F) : const Color(0xFFD0517F);
  }

  static Color getResetColor() {
    return Get.isDarkMode ? const Color(0xFF8B8989) : const Color(0xFFECF1F7);
  }
  ///#686868
  static const Color colorPrimary = Color(0xFF003E47);
  static const Color colorPrint = Color(0xFF0060D5);
  static const Color colorReset = Color(0xFFECF1F7);
  static const Color downloadFormat = Color(0xFF009CD6);
  static const Color colorGrey = Color(0xFFA0A4A8);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorLightBlack = Color(0xFF4A4B4D);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorTab = Color(0xFFFFFFFF);
  static const Color colorHint = Color(0xFF52575C);
  static const Color searchBg = Color(0xFFF4F7FC);



  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };
  static const List<Color> ssColor = [
    Color(0xFF008926),
    Color(0xFF5CAE7F),
    Color(0xFF008926),
    Color(0xFF008926),
    Color(0xFF5CAE7D),
    Color(0xFF008926),
  ];

  //
  static Color secondaryColor = const Color(0xFFE0EC53);
  static const Color primaryColor = Color(0xFF003E47);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color blackColor = const Color(0xFF000000);
  static Color gradientColor = const Color(0xFF45A735);
  static Color backgroundColor = const Color(0xFFE5E5E5);
  static Color balanceTextColor = const Color(0xFF393939);
  static Color cardOrangeColor = const Color(0xFFFFCB66);
  static Color cardPinkColor = const Color(0xFFF6BDE9);
  static Color cardPestColor = const Color(0xFFACD9B3);
  static Color containerShedow = const Color(0xFF757575);
  static Color websiteTextColor = const Color(0xFF344968);
  static Color nevDefaultColor = const Color(0xFFAAAAAA);
  static Color blueColor = const Color(0xFF5680F9);
  static Color textFieldColor = const Color(0xFFF2F2F6);
  static Color otpFieldColor = const Color(0xFFF2F2F7);
  static Color redColor = const Color(0xFFFF0000);
  static Color phoneNumberColor = const Color(0xFF484848);
  static Color themeLightBackgroundColor = const Color(0xFFFAFAFA);
  static Color themeDarkBackgroundColor = const Color(0xFF343636);
  //other info
  //#6a6e81
static Color genderDefaultColor = const Color(0xFFe3f3fd);
static Color hintColor = const Color(0xFF8E8E93);
static Color textFieldBorderColor = const Color(0xFFD1D1D6);

//shimmer Color
static Color? shimmerBaseColor =  Colors.grey[350];
static Color? shimmerLightColor =  Colors.grey[200];

/// qr code scanner screen
  static Color containerColor = const Color(0xFFD1D1D6);
}
