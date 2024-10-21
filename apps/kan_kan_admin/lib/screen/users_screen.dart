import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/dummydata.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';

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
            child: Theme(
              data: ThemeData(
                  cardTheme: const CardTheme(
                    shape: RoundedRectangleBorder(),
                    color: Colors.white,
                    elevation: 0,
                  ),
                  iconButtonTheme: const IconButtonThemeData(
                    style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll(Colors.black),
                    ),
                  ),
                  dataTableTheme: const DataTableThemeData(
                    dividerThickness: 0,
                  )),
              child: PaginatedDataTable(
                showEmptyRows: false,
                showFirstLastButtons: true,
                headingRowColor: const WidgetStatePropertyAll(Colors.white),
                onPageChanged: (value) {},
                source: TableDataRow(
                  length: userList.length,
                  customRow: List.generate(
                    userList.length,
                    (index) => DataRow(
                      color: WidgetStateProperty.all(Colors.white),
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
                    label: const Text("ID"),
                  ),
                  DataColumn(
                    onSort: (columnIndex, ascending) {
                      if (ascending) {
                        userList = userList.reversed.toList();
                      }
                    },
                    label: const Text("Name"),
                  ),
                  const DataColumn(
                    label: Text("Email"),
                  ),
                  const DataColumn(
                    label: Text("Phone Number"),
                  ),
                  const DataColumn(
                    label: Text("Region"),
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
