import 'package:flutter/material.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/text_theme.dart';

import 'custom_elevated_button_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      useMaterial3: true,
      fontFamily: 'Tajawal',
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.bg,
      iconTheme: const IconThemeData(color: AppColor.white),
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      textTheme: TTextTheme.lightTextTheme);
}
