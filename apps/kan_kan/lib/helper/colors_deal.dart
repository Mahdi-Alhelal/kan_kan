import 'package:flutter/material.dart';
import 'package:kan_kan/helper/deal_enums.dart';

Color getDealEnumColor(DealEnums dealEnum) {
  switch (dealEnum) {
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
