import 'dart:io';
import 'package:flutter/material.dart';

const Color primaryColorDark = Color(0xff000000);
const Color primaryColorLight = Color(0xff000000);
const Color greyColor = Color(0xffa5a5a5);
const Color lightGreyColor = Color(0xffEDEDED);
const Color loaderBg = Color(0xbfffffff);
const Color mediumGreyColor = Color(0x99c6c6c6);
const Color blackColor = Color(0xff000000);
const Color whiteColor = Color(0xffffffff);
const Color greenColor = Color(0xff008000);
const Color yellowColor = Color(0xffe2af08);
const Color disabledButtonColor = Color(0x990754a8);
const Color redColor = Color(0xfff63939);
const Color bgColor = Color(0xff525252);
const Color gd2 = Color(0xff1b1b1b);
const Color gd1 = Color(0xff525252);
const Color cardBgColor = Color(0xff464747);
const Color statusBarColor = Color(0xff4f4f4f);

const String rightQuote = "assets/icons/right_quote.png";
const String leftQuote = "assets/icons/left_quote.png";
const String placeHolder = "assets/icons/placeholder_quote.png";
const String appLogo = "assets/icons/app_logo.png";

class Themes {
  static ThemeData defaultTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black54,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: whiteColor),
        titleTextStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: whiteColor)),
    colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark, primary: bgColor, secondary: bgColor),
  );
}

class Constant {
  static List<Color> colors = [
    Colors.pink.shade100,
    Colors.lightGreen.shade100,
    Colors.lightBlue.shade100,
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.teal.shade100,
  ];

  static List<String> images = [
    "https://images.pexels.com/photos/2088203/pexels-photo-2088203.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1762851/pexels-photo-1762851.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1939485/pexels-photo-1939485.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/459335/pexels-photo-459335.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  ];

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
