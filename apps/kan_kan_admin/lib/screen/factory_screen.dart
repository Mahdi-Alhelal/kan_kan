import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/dymmy%20data/factory_dummy_data.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:ui/ui.dart';
import 'dart:ui' as ui;

class FactoryScreen extends StatelessWidget {
  const FactoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddButton(
            onPressed: () {},
          ),
          SizedBox(
            child: CustomTableTheme(
              child: PaginatedDataTable(
                showEmptyRows: false,
                headingRowColor: const WidgetStatePropertyAll(AppColor.white),
                source: TableDataRow(
                  length: factoryList.length,
                  customRow: List.generate(
                    factoryList.length,
                    (index) => DataRow(
                      color: WidgetStateProperty.all(AppColor.white),
                      cells: [
                        DataCell(
                          Row(
                            children: [Text(factoryList[index].factoryName)],
                          ),
                        ),
                        DataCell(Text(factoryList[index].factoryRepsentive)),
                        DataCell(Directionality(
                            textDirection: ui.TextDirection.ltr,
                            child: Text(factoryList[index].phoneNumber))),
                        DataCell(Text(factoryList[index].type)),
                        DataCell(Text(factoryList[index].region)),
                        DataCell(
                            FactoryStatus(status: factoryList[index].status)),
                      ],
                    ),
                  ),
                ),
                columns: [
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("مصنع"),
                  ),
                  DataColumn(
                    onSort: (columnIndex, ascending) {
                      if (ascending) {
                        factoryList = factoryList.reversed.toList();
                      }
                    },
                    label: const Text("ممثل المصنع"),
                  ),
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("رقم التواصل"),
                  ),
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("نوع التصنيع"),
                  ),
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("المنطقة"),
                  ),
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("حالة المصنع"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FactoryStatus extends StatelessWidget {
  const FactoryStatus({
    super.key,
    required this.status,
  });
  final String status;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .07,
        height: MediaQuery.of(context).size.height * .05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: statusColors(status: status),
          ),
        ),
        child: Center(
          child: Text(
            style: TextStyle(
                color: statusColors(status: status),
                fontWeight: FontWeight.bold),
            status,
          ),
        ),
      ),
    );
  }
}

Color statusColors({required String status}) {
  switch (status) {
    case "نشط":
      return Color(0xff0CAF60);

    case "غير نشط":
      return Colors.red;

    case "قيد المراجعة":
      return Colors.orange;

    default:
      return Colors.white;
  }
}
