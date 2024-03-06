import 'package:flutter/material.dart';

class AppTheme {

  static const Color primary = Color(0xFFf02b25);
  static const Color allWhite = Color(0xFFFFFFFF); // 纯白

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  // swiper
  static const Color swiperColor = Color.fromARGB(255, 255, 255, 255);
  static const Color swiperActiveColor = Color.fromRGBO(230, 0,38, 1);

  // my color
  static const Color myBg = Color(0xFFf8f9fd);
  static const Color myLogoBg = Color(0xFF4e1413);
  static const Color myLogoBgBtn = Color(0xFF663635);
  static const Color myLogoBtnIcon = Color(0xFFdfd8d3);
  static const Color myLoveSing = Color(0xFFe9ecf1);
  static const Color myLoveSingText = Color(0xFF3c3c3c);
  static const Color myLoveSingSubtext = Color(0xFF81858e); // 95969c a5a6ac 81858e

  // song deatil
  static const Color songDetailBg = Color(0xFF8d494a);
  static const Color songDetailBg2 = Color(0xFFa76163); // a76163
  static const Color songDeatilBtnBg = Color(0xFFb77d7c); // b77d7c
  static const Color songDeatilSamllSize = Color(0xFFdfb4b2); // dfb4b2

  // 备用色调
  static const Color primaryColor1 = Color.fromARGB(237, 252, 243, 236);

}

ThemeData appMusicTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.myLogoBgBtn),
);