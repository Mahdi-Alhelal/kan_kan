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
        final userCubit = context.read<UserCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableSizedBox(
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return CustomTableTheme(
                      child: PaginatedDataTable(
                        showEmptyRows: false,
                        source: TableDataRow(
                          length: userCubit.userLayer.usersList.length,
                          customRow: List.generate(
                            userCubit.userLayer.usersList.length,
                            (index) => DataRow(
                              color: WidgetStateProperty.all(AppColor.white),
                              cells: [
                                DataCell(Text(userCubit
                                    .userLayer.usersList[index].userId
                                    .substring(0, 5))),
                                DataCell(Text(userCubit
                                    .userLayer.usersList[index].fullName)),
                                DataCell(Text(userCubit
                                    .userLayer.usersList[index].email)),
                                DataCell(
                                  Directionality(
                                    textDirection: ui.TextDirection.ltr,
                                    child: Text(userCubit
                                        .userLayer.usersList[index].phone),
                                  ),
                                ),
                                //DataCell(Text(userList[index].region!)),
                                DataCell(CustomChips(
                                  status: "فعال",
                                  onTap: () async {
                                    await updateStatus(
                                        value: DropMenuList.userStatus.first,
                                        onChanged: (value) {},
                                        context: context,
                                        title: "حالة",
                                        onPressed: () {},
                                        items: DropMenuList.userStatus
                                            .map<DropdownMenuItem<String>>(
                                                (String status) {
                                          return DropdownMenuItem(
                                            value: status,
                                            child: Text(status),
                                          );
                                        }).toList());
                                  },
                                )),
                              ],
                            ),
                          ),
                        ),
                        columns: const [
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            // onSort: (columnIndex, ascending) {
                            //   if (ascending) {
                            //     userList.sort(
                            //       (a, b) => a.userId.compareTo(b.userId),
                            //     );
                            //   } else {
                            //     userList.sort(
                            //         (a, b) => b.userId.compareTo(a.userId));
                            //   }
                            // },
                            label: Text("#"),
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            // onSort: (columnIndex, ascending) {
                            //   if (ascending) {
                            //     userList = userList.reversed.toList();
                            //   }
                            // },
                            label: Text("اسم"),
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("البريد"),
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("رقم الهاتف"),
                          ),
                          // DataColumn(
                          //   headingRowAlignment: MainAxisAlignment.center,
                          //   label: Text("منطقة"),
                          // ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("حالة المستخدم"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
