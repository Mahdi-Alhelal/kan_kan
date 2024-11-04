import 'package:flutter/material.dart';
import 'package:helper/src/deal_enums.dart';
import 'package:helper/src/order_enums.dart';

Color colorStatus(value) {
  switch (value) {
    case "active" || true:
      return Colors.blue;
    case "blocked" || false:
      return Colors.red;
    case "admin":
      return Colors.purple;
    case "user":
      return Colors.indigo;
    case "paid":
      return Colors.green;
    case "failed":
      return Colors.red;
    case "refund":
      return Colors.lightGreen;
    case "pending":
      return Colors.orange;
    case "processing":
      return Colors.teal;
    case "inChina":
      return Colors.blueGrey;
    case "inTransit":
      return Colors.amber;
    case "inSaudi":
      return Colors.yellow;
    case "withShipmentCompany":
      return Colors.pink;
    case "completed":
      return Colors.green;
    case "canceled":
      return Colors.red;
    case "private":
      return Colors.grey;
    case "closed":
      return Colors.black;
    default:
      return Colors.black;
  }
}

Color getEnumColor(var value) {
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
      return Colors.greenAccent;
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
