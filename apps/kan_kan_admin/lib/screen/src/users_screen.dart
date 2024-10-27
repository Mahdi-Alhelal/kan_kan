import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan_admin/cubits/user_cubit/user_cubit.dart';
import 'package:kan_kan_admin/dummy_data/status_list.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/dummy_data/dummydata.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/ui.dart';
import 'dart:ui' as ui;

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: Builder(builder: (context) {
        final user_cubit = context.read<UserCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableSizedBox(
                child: CustomTableTheme(
                  child: PaginatedDataTable(
                    showEmptyRows: false,
                    source: TableDataRow(
                      length: userList.length,
                      customRow: List.generate(
                        userList.length,
                        (index) => DataRow(
                          color: WidgetStateProperty.all(AppColor.white),
                          cells: [
                            DataCell(
                              Text(userList[index].id),
                            ),
                            DataCell(Text(userList[index].name)),
                            DataCell(Text(userList[index].email)),
                            DataCell(
                              Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Text(userList[index].phoneNumber),
                              ),
                            ),
                            DataCell(Text(userList[index].region!)),
                            DataCell(CustomChips(
                              status: "فعال",
                              onTap: () async {
                                await user_cubit.userEvent();
                                print("here");
                                // await updateStatus(
                                //     value: DropMenuList.userStatus.first,
                                //     onChanged: (value) {},
                                //     context: context,
                                //     title: "حالة",
                                //     onPressed: () {},
                                //     items: DropMenuList.userStatus
                                //         .map<DropdownMenuItem<String>>(
                                //             (String status) {
                                //       return DropdownMenuItem(
                                //         value: status,
                                //         child: Text(status),
                                //       );
                                //     }).toList());
                              },
                            )),
                          ],
                        ),
                      ),
                    ),
                    columns: [
                      DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
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
                        headingRowAlignment: MainAxisAlignment.center,
                        onSort: (columnIndex, ascending) {
                          if (ascending) {
                            userList = userList.reversed.toList();
                          }
                        },
                        label: const Text("اسم"),
                      ),
                      const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text("البريد"),
                      ),
                      const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text("رقم الهاتف"),
                      ),
                      const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text("منطقة"),
                      ),
                      const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text("حالة المستخدم"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
