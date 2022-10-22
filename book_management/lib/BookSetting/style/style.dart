import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: isDarkTheme == true ? Colors.black : Colors.white,
      backgroundColor: isDarkTheme == true ? Colors.black : Color(0xffF1F5FB),
      textSelectionColor:
          isDarkTheme == true ? Colors.white : HexColor("#B6442A"),
      canvasColor: isDarkTheme == true ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme == true ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          color:
              isDarkTheme == true ? HexColor("#292929") : HexColor("#F9E1E1"),
          titleTextStyle: GoogleFonts.rozhaOne(
              textStyle: TextStyle(
                  color:
                      isDarkTheme == true ? Colors.white : HexColor("#B6442A"),
                  fontWeight: FontWeight.w400,
                  fontSize: 20))),
    );
  }
}
