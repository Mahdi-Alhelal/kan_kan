import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan_admin/cubits/factory_cubit/factory_cubit.dart';
import 'package:kan_kan_admin/dummy_data/status_list.dart';
import 'package:kan_kan_admin/helper/factory_status.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
import 'package:kan_kan_admin/widget/form/factory_form.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/ui.dart';
import 'dart:ui' as ui;

class FactoryScreen extends StatefulWidget {
  const FactoryScreen({super.key});

  @override
  State<FactoryScreen> createState() => _FactoryScreenState();
}

class _FactoryScreenState extends State<FactoryScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FactoryCubit(),
      child: Builder(builder: (context) {
        final factoryCubit = context.read<FactoryCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<FactoryCubit, FactoryState>(
                builder: (context, state) {
                  return AddButton(
                    onPressed: () {
                      customBottomSheet(
                        context: context,
                        child: FactoryForm(
                            formKey: formKey,
                            factoryNameController:
                                factoryCubit.factoryNameController,
                            regionController: factoryCubit.regionController,
                            typeController: factoryCubit.departmentController,
                            repController: factoryCubit.repController,
                            phoneNumberController:
                                factoryCubit.phoneNumberController,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                factoryCubit.addFactoryEvent();
                                Navigator.pop(context);
                              }
                            }),
                      );
                    },
                  );
                },
              ),
              BlocBuilder<FactoryCubit, FactoryState>(
                builder: (context, state) {
                  return TableSizedBox(
                    child: CustomTableTheme(
                      child: PaginatedDataTable(
                        showEmptyRows: false,
                        source: TableDataRow(
                          length: factoryCubit.factoryLayer.factories.length,
                          customRow: List.generate(
                            factoryCubit.factoryLayer.factories.length,
                            (index) => DataRow(
                              color: WidgetStateProperty.all(AppColor.white),
                              cells: [
                                DataCell(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          factoryCubit
                                                  .factoryNameController.text =
                                              factoryCubit.factoryLayer
                                                  .factories[index].factoryName;
                                          factoryCubit.regionController.text =
                                              factoryCubit.factoryLayer
                                                  .factories[index].region;
                                          factoryCubit
                                                  .departmentController.text =
                                              factoryCubit.factoryLayer
                                                  .factories[index].department;
                                          factoryCubit.repController.text =
                                              factoryCubit
                                                  .factoryLayer
                                                  .factories[index]
                                                  .factoryRepresentative;

                                          factoryCubit
                                                  .phoneNumberController.text =
                                              factoryCubit
                                                  .factoryLayer
                                                  .factories[index]
                                                  .contactPhone;

                                          customBottomSheet(
                                            context: context,
                                            child: FactoryForm(
                                                formKey: formKey,
                                                factoryNameController:
                                                    factoryCubit
                                                        .factoryNameController,
                                                regionController: factoryCubit
                                                    .regionController,
                                                typeController: factoryCubit
                                                    .departmentController,
                                                repController:
                                                    factoryCubit.repController,
                                                phoneNumberController:
                                                    factoryCubit
                                                        .phoneNumberController,
                                                onPressed: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    factoryCubit
                                                        .updateFactoryEvent(
                                                            factoryId:
                                                                factoryCubit
                                                                    .factoryLayer
                                                                    .factories[
                                                                        index]
                                                                    .factoryId);
                                                    Navigator.pop(context);
                                                  }
                                                }),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      Text(
                                          "${factoryCubit.factoryLayer.factories[index].factoryName}\n${factoryCubit.factoryLayer.factories[index].factoryId}"),
                                    ],
                                  ),
                                ),
                                DataCell(Center(
                                  child: Text(factoryCubit.factoryLayer
                                      .factories[index].factoryRepresentative),
                                )),
                                DataCell(Directionality(
                                    textDirection: ui.TextDirection.ltr,
                                    child: Center(
                                      child: Text(factoryCubit.factoryLayer
                                          .factories[index].contactPhone),
                                    ))),
                                DataCell(Center(
                                  child: Text(factoryCubit.factoryLayer
                                      .factories[index].department),
                                )),
                                DataCell(Center(
                                  child: Text(factoryCubit
                                      .factoryLayer.factories[index].region),
                                )),
                                DataCell(CustomChips(
                                  status: factoryStatus(factoryCubit
                                      .factoryLayer
                                      .factories[index]
                                      .isBlackList),
                                  onTap: () async {
                                    await updateStatus(
                                        value: DropMenuList.factoryStatus.first,
                                        context: context,
                                        title: "حالة",
                                        onChanged: (value) {},
                                        items: DropMenuList.factoryStatus
                                            .map<DropdownMenuEntry<String>>(
                                                (String status) {
                                          return DropdownMenuEntry(
                                            value: status,
                                            label: status,
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
                            onSort: (columnIndex, ascending) {
                              

                              if (ascending) {
                                factoryCubit.factoryLayer.factories.sort(
                                  (a, b) =>
                                      a.factoryName.compareTo(b.factoryName),
                                );
                              } else {
                                factoryCubit.factoryLayer.factories.sort(
                                  (a, b) =>
                                      b.factoryName.compareTo(a.factoryName),
                                );
                              }
                              factoryCubit.sortEvent();
                            },
                            headingRowAlignment: MainAxisAlignment.center,
                            label: const Text("المصنع"),
                          ),
                          const DataColumn(
                            label: Text("ممثل المصنع"),
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
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
