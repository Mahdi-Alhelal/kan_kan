import 'package:flutter/material.dart';

Color statusColors({required String status}) {
  switch (status) {
    case "نشط":
      return Color(0xff0CAF60);

    case "غير نشط":
      return Colors.red;

    case "قيد المراجعة":
      return Colors.orange;

    default:
      return Colors.black;
  }
}
