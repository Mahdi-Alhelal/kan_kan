import 'package:flutter/material.dart';
import 'package:helper/src/deal_enums.dart';
import 'package:helper/src/order_enums.dart';

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

Color getEnumColor(var value) {
  print(value.toString());
  switch (value) {
    case false:
      return Colors.red;
    case true:
      return Colors.green;
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
    case OrderStatus.pending:
      return Colors.orange;
    case OrderStatus.processing:
      return Colors.teal;
    case OrderStatus.inChina:
      return Colors.blueGrey;
    case OrderStatus.inTransit:
      return Colors.amber;
    case OrderStatus.inSaudi:
      return Colors.yellow;
    case OrderStatus.withShipmentCompany:
      return Colors.pink;
    case OrderStatus.completed:
      return Colors.green;
    case OrderStatus.canceled:
      return Colors.red;
    default:
      return Colors.black;
  }
}
