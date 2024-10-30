import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan_admin/cubits/user_cubit/user_cubit.dart';
import 'package:helper/src/enums.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';
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
                        sortAscending: userCubit.sort,
                        sortColumnIndex: userCubit.columnIndex,
                        source: TableDataRow(
                          length: userCubit.userLayer.usersList.length,
                          customRow: List.generate(
                            userCubit.userLayer.usersList.length,
                            (index) => DataRow(
                              onLongPress: () {
                                userCubit.userPhoneController.text =
                                    userCubit.userLayer.usersList[index].phone;

                                userCubit.userFullNameController.text =
                                    userCubit
                                        .userLayer.usersList[index].fullName;
                                userCubit.userEmailController.text =
                                    userCubit.userLayer.usersList[index].email;
                                userCubit.userBalanceController.text = userCubit
                                    .userLayer.usersList[index].balance
                                    .toString();

                                customBottomSheet(
                                    context: context,
                                    height: 0.8,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomTextField(
                                            title: "اسم العميل",
                                            controller: userCubit
                                                .userFullNameController,
                                          ),
                                          CustomTextField(
                                            title: "البريد الإلكتروني",
                                            controller:
                                                userCubit.userEmailController,
                                            readOnly: true,
                                          ),
                                          CustomTextField(
                                            title: "رقم الجوال",
                                            controller:
                                                userCubit.userPhoneController,
                                          ),
                                          CustomTextField(
                                            title: "الرصيد",
                                            controller:
                                                userCubit.userBalanceController,
                                          ),
                                          SizedBox(
                                            width:
                                                context.getWidth(value: 0.25),
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  await userCubit.updateUserEvent(
                                                      userID: userCubit
                                                          .userLayer
                                                          .usersList[index]
                                                          .userId,
                                                      fullName: userCubit
                                                          .userFullNameController
                                                          .text,
                                                      phone: userCubit
                                                          .userPhoneController
                                                          .text,
                                                      status: "active",
                                                      balance: userCubit
                                                          .userBalanceController
                                                          .text);
                                                  print("done");
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text("حفظ")),
                                          )
                                        ],
                                      ),
                                    ));
                              },
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
                                DataCell(CustomChips(
                                  status: UserStatusEnum.values.first.value,
                                  onTap: () async {
                                    await updateStatus(
                                        value: UserStatusEnum.values.first.name,
                                        onChanged: (value) {
                                          print(value);
                                        },
                                        context: context,
                                        title: "حالة المصنع",
                                        onPressed: () {},
                                        items:
                                            UserStatusEnum.values.map((status) {
                                          return DropdownMenuEntry(
                                            value: status.name,
                                            label: status.value,
                                          );
                                        }).toList());
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
                              if (userCubit.sort) {
                                userCubit.userLayer.usersList.sort(
                                  (a, b) => a.userId.compareTo(b.userId),
                                );
                              } else {
                                userCubit.userLayer.usersList.sort(
                                    (a, b) => b.userId.compareTo(a.userId));
                              }
                              userCubit.sort = !userCubit.sort;
                              userCubit.columnIndex = columnIndex;
                              userCubit.sortEvent();
                            },
                            label: const Text("#"),
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            onSort: (columnIndex, ascending) {
                              if (userCubit.sort) {
                                userCubit.userLayer.usersList.sort(
                                  (a, b) => a.fullName.compareTo(b.fullName),
                                );
                              } else {
                                userCubit.userLayer.usersList.sort(
                                    (a, b) => b.fullName.compareTo(a.fullName));
                              }
                              userCubit.sort = !userCubit.sort;
                              userCubit.columnIndex = columnIndex;
                              userCubit.sortEvent();
                            },
                            label: const Text("اسم"),
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: const Text("البريد"),
                            onSort: (columnIndex, ascending) {
                              if (userCubit.sort) {
                                userCubit.userLayer.usersList.sort(
                                  (a, b) => a.email.compareTo(b.email),
                                );
                              } else {
                                userCubit.userLayer.usersList
                                    .sort((a, b) => b.email.compareTo(a.email));
                              }
                              userCubit.sort = !userCubit.sort;
                              userCubit.columnIndex = columnIndex;
                              userCubit.sortEvent();
                            },
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: const Text("رقم الهاتف"),
                            onSort: (columnIndex, ascending) {
                              if (userCubit.sort) {
                                userCubit.userLayer.usersList.sort(
                                  (a, b) => a.phone.compareTo(b.phone),
                                );
                              } else {
                                userCubit.userLayer.usersList
                                    .sort((a, b) => b.phone.compareTo(a.phone));
                              }
                              userCubit.sort = !userCubit.sort;
                              userCubit.columnIndex = columnIndex;
                              userCubit.sortEvent();
                            },
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("حالة المستخدم"),
                            onSort: (columnIndex, ascending) {
                              if (userCubit.sort) {
                                userCubit.userLayer.usersList.sort(
                                  (a, b) =>
                                      a.userStatus.compareTo(b.userStatus),
                                );
                              } else {
                                userCubit.userLayer.usersList.sort((a, b) =>
                                    b.userStatus.compareTo(a.userStatus));
                              }
                              userCubit.sort = !userCubit.sort;
                              userCubit.columnIndex = columnIndex;
                              userCubit.sortEvent();
                            },
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
