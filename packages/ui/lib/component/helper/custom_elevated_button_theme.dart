import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          textStyle: TextStyle(
              fontSize: 16, color: AppColor.white, fontWeight: FontWeight.w700),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))));
}
