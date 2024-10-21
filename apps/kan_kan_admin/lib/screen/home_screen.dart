import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/dummydata.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: PaginatedDataTable(
            showFirstLastButtons: true,
            rowsPerPage: 3,
            showCheckboxColumn: true,
            source: TableDataRow(
              length: userList.length,
              customRow: 
                List.generate(userList.length, (index) =>
                   DataRow(cells: [
                    DataCell(
                      Row(
                        children: [
                          Radio(
                            value: userList[index].id,
                            groupValue: index,
                            onChanged: (value) {
                              
                            },
                          ),
                          Text(userList[index].id)
                        ],
                      ),
                    ),
                    DataCell(Text(userList[index].name)),
                    DataCell(Text(userList[index].email)),
                    DataCell(Text(userList[index].phoneNumber)),
                    DataCell(Text(userList[index].region)),
                  ])
                )
              
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
    );
  }
}

