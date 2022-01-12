import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkTheme ? Color(0xff0E1D36) : Colors.grey.shade200,
      primarySwatch: Colors.orange,
      primaryColor: isDarkTheme ? Color(0xff0E1D36) : Colors.grey.shade200,
      accentColor: Colors.deepOrange,
      backgroundColor: isDarkTheme ? Colors.grey.shade50 : Colors.grey[200],
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      buttonColor: isDarkTheme ? Color(0xFFEEEEEE) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Colors.grey.shade50 : Colors.grey.shade100,
      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xFFEEEEEE) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey[50],
      textSelectionColor: isDarkTheme ? Colors.grey[400] : Colors.black,
      cardColor: isDarkTheme ? Color(0xff0E1D36) : Colors.white,
      canvasColor: isDarkTheme ? Color(0xff0E1D36) : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
