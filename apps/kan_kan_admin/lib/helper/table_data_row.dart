import 'package:flutter/material.dart';

class TableDataRow extends DataTableSource {
  late final int length;
  late List<DataRow?> customRow;
  TableDataRow({required this.length,required this.customRow});

  @override
  DataRow? getRow(int index) => customRow[index];

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => length;

  @override
  int get selectedRowCount => 0;
}
