import 'package:flutter/material.dart';
import 'package:helper/src/deal_enums.dart';

Color statusColors({required String status}) {
  switch (status) {
    case "نشط":
      return const Color(0xff0CAF60);

    case "غير نشط":
      return const Color(0xFFF44336);

    case "قيد المراجعة":
      return const Color(0xFFFF9800);

    default:
      return const Color(0xFF000000);
  }
}

Color getDealEnumColor(var value) {
  switch (value) {
    case DealEnums.completed:
      return Colors.green;
    case DealEnums.active:
      return Colors.blue;
    case DealEnums.pending:
      return Colors.orange;
    case DealEnums.closed:
      return Colors.red;
    case DealEnums.private:
      return Colors.grey;
     
    default:
      return Colors.black;
  }
}
