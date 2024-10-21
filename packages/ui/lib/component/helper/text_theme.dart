import 'package:flutter/material.dart';

import 'custom_colors.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = const TextTheme(
      headlineLarge: TextStyle(fontSize: 20, color: AppColor.primary),
      headlineMedium: TextStyle(fontSize: 18, color: AppColor.primary),
      headlineSmall: TextStyle(fontSize: 16, color: AppColor.primary),
      //title
      titleLarge: TextStyle(fontSize: 22, color: AppColor.primary),
      titleMedium: TextStyle(fontSize: 16, color: AppColor.primary),
      titleSmall: TextStyle(fontSize: 14, color: AppColor.primary),

      //body
      bodySmall: TextStyle(fontSize: 12, color: AppColor.primary),
      bodyMedium: TextStyle(fontSize: 14, color: AppColor.primary),
      bodyLarge: TextStyle(fontSize: 16, color: AppColor.primary));
}
