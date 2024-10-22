import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/dummy%20data/factory_dummy_data.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';
import 'package:kan_kan_admin/widget/chip/factory_status.dart';
import 'package:kan_kan_admin/widget/form/custom_from.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/ui.dart';
import 'dart:ui' as ui;

class FactoryScreen extends StatelessWidget {
  const FactoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController factoryNameController = TextEditingController();
    TextEditingController regionController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController repController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddButton(
            onPressed: () {
              customBottomSheet(
                context: context,
                child: CustomForm(
                    factoryNameController: factoryNameController,
                    regionController: regionController,
                    typeController: typeController,
                    repController: repController,
                    phoneNumberController: phoneNumberController,
                    onPressed: () {}),
              );
            },
          ),
          TableSizedBox(
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
                            CustomChips(status: factoryList[index].status)),
                      ],
                    ),
                  ),
                ),
                columns: [
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("المصنع"),
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
                    label: Text("نوع تصنيع"),
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
