import 'package:flutter/material.dart';
import 'package:car_service/theme/colors.dart';

class AppTheme {
  static final  colors = AppColors();

   AppTheme._();

  static ThemeData define() {
    return ThemeData(
      fontFamily: "",
      primaryColor: Color(0xFF083863),
      focusColor: Color(0xFF083863),
    );
  }
}
