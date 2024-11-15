import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/cubits/deal_cubit/deal_cubit.dart';
import 'package:kan_kan_admin/local_data/status_list.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/screen/src/deals_details_screen.dart';
import 'package:kan_kan_admin/widget/form/add_deal_form.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key});

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DealCubit(),
      child: Builder(builder: (context) {
        final dealCubit = context.read<DealCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddButton(
                onPressed: () {
                  customBottomSheet(
                    context: context,
                    child: AddDealForm(
                      totalController: dealCubit.totalCostController,
                      dealCategory: dealCubit.categoryLayer.categories,
                      productsList: dealCubit.productLayer.products
                          .where((product) =>
                              dealCubit.factoryLayer
                                  .getFactory(id: product.factory.factoryId)
                                  .isBlackList ==
                              false)
                          .toList(),
                      dealNameController: dealCubit.dealNameController,
                      productController: dealCubit.productController,
                      quantityController: dealCubit.quantityController,
                      maxNumberController: dealCubit.maxNumberController,
                      dealStatusController: dealCubit.dealStatusController,
                      dealTypeController: dealCubit.dealTypeController,
                      dealDurationController: dealCubit.dealDurationController,
                      priceController: dealCubit.priceController,
                      costController: dealCubit.costController,
                      deliveryCostController: dealCubit.deliveryCostController,
                      estimatedTimeToController:
                          dealCubit.estimatedTimeToController,
                      estimatedTimeFromController:
                          dealCubit.estimatedTimeFromController,
                      formKey: formKey,
                      dealDuration: () async {
                        final date = await showCalendarDatePicker2Dialog(
                          context: context,
                          config: CalendarDatePicker2WithActionButtonsConfig(
                              firstDate: DateTime.now(),
                              calendarType: CalendarDatePicker2Type.range),
                          dialogSize: Size(
                            context.getWidth(value: 0.5),
                            context.getHeight(value: 0.5),
                          ),
                        );
                        try {
                          dealCubit.dealDuration = date!;
                          dealCubit.dealDurationController.text =
                              "${DateConverter.saDateFormate(dealCubit.dealDuration.first.toString())} الى ${DateConverter.saDateFormate(dealCubit.dealDuration.last.toString())}";
                        } catch (e) {
                          dealCubit.dealDurationController.clear();
                        }
                      },
                      add: () {
                        if (formKey.currentState!.validate()) {
                          dealCubit.addDeal();
                          Navigator.pop(context);
                        }
                      },
                      uploadImage: () async {
                        try {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );
                          if (result != null) {
                            dealCubit.image = File(result.files.single.path!);
                          }
                        } catch (e) {
                          dealCubit.image = null;
                        }
                      },
                    ),
                  );
                },
              ),
              TableSizedBox(
                child: CustomTableTheme(
                  child: BlocBuilder<DealCubit, DealState>(
                    builder: (context, state) {
                      return PaginatedDataTable(
                        sortAscending: dealCubit.sort,
                        sortColumnIndex: dealCubit.columnIndex,
                        showEmptyRows: false,
                        source: TableDataRow(
                          length: dealCubit.dealLayer.deals.length,
                          customRow: List.generate(
                            dealCubit.dealLayer.deals.length,
                            (index) => DataRow(
                              onLongPress: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DealsDetailsScreen(
                                      dealId: dealCubit
                                          .dealLayer.deals[index].dealId,
                                    ),
                                  ),
                                ).then((_) {
                                  dealCubit.getNewOrder();
                                  dealCubit.getNewUser();
                                  dealCubit.completeDeal();
                                  dealCubit.afterPop();
                                });
                              },
                              color: WidgetStateProperty.all(AppColor.white),
                              cells: [
                                DataCell(
                                  Row(
                                    children: [
                                      Text(
                                          "${dealCubit.dealLayer.deals[index].dealTitle}\n${dealCubit.dealLayer.deals[index].dealId}")
                                    ],
                                  ),
                                ),
                                DataCell(Text(
                                    "${dealCubit.dealLayer.deals[index].startDate} الى ${dealCubit.dealLayer.deals[index].endDate}")),
                                DataCell(Text(
                                    "${dealCubit.dealLayer.deals[index].quantity}/${dealCubit.dealLayer.deals[index].numberOfOrder}")),
                                DataCell(CustomChips(
                                  statusColor: dealCubit
                                      .dealLayer.deals[index].dealStatus,
                                  status: dealCubit
                                      .dealLayer.deals[index].dealStatus,
                                  onTap: () async {
                                    dealCubit.tempStatus = dealCubit
                                        .dealLayer.deals[index].dealStatus;
                                    await updateStatus(
                                        value: dealCubit
                                            .dealLayer.deals[index].dealStatus,
                                        context: context,
                                        title: "حالة",
                                        onChanged: (value) {
                                          dealCubit.tempStatus =
                                              value.toString();
                                        },
                                        onPressed: () async {
                                          await dealCubit.updateDealStatusEvent(
                                              index: index,
                                              dealId: dealCubit.dealLayer
                                                  .deals[index].dealId);
                                        },
                                        items: DropMenuList.dealStatus
                                            .map<DropdownMenuItem<String>>(
                                                (String status) {
                                          return DropdownMenuItem(
                                            value: status,
                                            child: Text(status).tr(),
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
                            label: const Text("المنتج"),
                            onSort: (columnIndex, ascending) {
                              if (dealCubit.sort) {
                                dealCubit.dealLayer.deals.sort(
                                  (a, b) => a.dealId.compareTo(b.dealId),
                                );
                              } else {
                                dealCubit.dealLayer.deals.sort(
                                  (a, b) => b.dealId.compareTo(a.dealId),
                                );
                              }
                              dealCubit.sort = !dealCubit.sort;
                              dealCubit.columnIndex = columnIndex;
                              dealCubit.sortEvent();
                            },
                          ),
                          DataColumn(
                            onSort: (columnIndex, ascending) {
                              if (dealCubit.sort) {
                                dealCubit.dealLayer.deals.sort((a, b) =>
                                    DateTime.parse(a.startDate).compareTo(
                                        DateTime.parse(b.startDate)));
                              } else {
                                dealCubit.dealLayer.deals.sort((a, b) =>
                                    DateTime.parse(b.startDate).compareTo(
                                        DateTime.parse(a.startDate)));
                              }
                              dealCubit.sort = !dealCubit.sort;
                              dealCubit.columnIndex = columnIndex;
                              dealCubit.sortEvent();
                            },
                            label: const Text("مدة صفقة"),
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("عدد "),
                            onSort: (columnIndex, ascending) {
                              if (dealCubit.sort) {
                                dealCubit.dealLayer.deals.sort((a, b) =>
                                    a.numberOfOrder.compareTo(b.numberOfOrder));
                              } else {
                                dealCubit.dealLayer.deals.sort((a, b) =>
                                    b.numberOfOrder.compareTo(a.numberOfOrder));
                              }
                              dealCubit.sort = !dealCubit.sort;
                              dealCubit.columnIndex = columnIndex;
                              dealCubit.sortEvent();
                            },
                          ),
                          DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text("الحالة"),
                            onSort: (columnIndex, ascending) {
                              if (dealCubit.sort) {
                                dealCubit.dealLayer.deals.sort((a, b) =>
                                    a.dealStatus.compareTo(b.dealStatus));
                              } else {
                                dealCubit.dealLayer.deals.sort((a, b) =>
                                    b.dealStatus.compareTo(a.dealStatus));
                              }
                              dealCubit.sort = !dealCubit.sort;
                              dealCubit.columnIndex = columnIndex;
                              dealCubit.sortEvent();
                            },
                          ),
                        ],
                      );
                    },
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
