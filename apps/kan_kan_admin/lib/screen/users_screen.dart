import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/dummydata.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:ui/ui.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

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
                  length: userList.length,
                  customRow: List.generate(
                    userList.length,
                    (index) => DataRow(
                      color: WidgetStateProperty.all(AppColor.white),
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Radio(
                                value: userList[index].id,
                                groupValue: index,
                                onChanged: (value) {},
                              ),
                              Text(userList[index].id)
                            ],
                          ),
                        ),
                        DataCell(Text(userList[index].name)),
                        DataCell(Text(userList[index].email)),
                        DataCell(Text(userList[index].phoneNumber)),
                        DataCell(Text(userList[index].region)),
                      ],
                    ),
                  ),
                ),
                columns: [
                  DataColumn(
                    onSort: (columnIndex, ascending) {
                      if (ascending) {
                        userList.sort(
                          (a, b) => a.id.compareTo(b.id),
                        );
                      } else {
                        userList.sort((a, b) => b.id.compareTo(a.id));
                      }
                    },
                    label: const Text("#"),
                  ),
                  DataColumn(
                    onSort: (columnIndex, ascending) {
                      if (ascending) {
                        userList = userList.reversed.toList();
                      }
                    },
                    label: const Text("اسم"),
                  ),
                  const DataColumn(
                    label: Text("البريد"),
                  ),
                  const DataColumn(
                    label: Text("رقم الهاتف"),
                  ),
                  const DataColumn(
                    label: Text("منطقة"),
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
