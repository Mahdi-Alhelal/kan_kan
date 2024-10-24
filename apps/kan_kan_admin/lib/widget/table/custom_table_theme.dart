import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class CustomTableTheme extends StatelessWidget {
  const CustomTableTheme({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            cardTheme: const CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              color: AppColor.white,
              elevation: 0,
            ),
            iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
                alignment: Alignment.centerRight,
                iconColor: WidgetStatePropertyAll(AppColor.black),
              ),
            ),
            dataTableTheme: const DataTableThemeData(),
            dividerColor: AppColor.primary),
        child: child);
  }
}
