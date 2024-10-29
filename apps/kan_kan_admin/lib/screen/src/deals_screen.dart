import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/cubits/deal_cubit/deal_cubit.dart';
import 'package:kan_kan_admin/dummy_data/status_list.dart';
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
                      productsList: dealCubit.productLayer.products,
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
                        }
                      },
                      uploadImage: () {},
                    ),
                  );
                },
              ),
              TableSizedBox(
                child: CustomTableTheme(
                  child: PaginatedDataTable(
                    showEmptyRows: false,
                    source: TableDataRow(
                      length: dealCubit.dealLayer.deals.length,
                      customRow: List.generate(
                        dealCubit.dealLayer.deals.length,
                        (index) => DataRow(
                          onLongPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DealsDetailsScreen(
                                deal: dealCubit.dealLayer.deals[index],
                              ),
                            ),
                          ),
                          color: WidgetStateProperty.all(AppColor.white),
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  Text(
                                      "${dealCubit.dealLayer.deals[index].product.productName}\n${dealCubit.dealLayer.deals[index].dealId}")
                                ],
                              ),
                            ),
                            DataCell(Text(
                                "${dealCubit.dealLayer.deals[index].startDate} الى ${dealCubit.dealLayer.deals[index].endDate}")),
                            DataCell(Text(
                                "${dealCubit.dealLayer.deals[index].quantity}/${dealCubit.dealLayer.deals[index].numberOfOrder}")),
                            DataCell(CustomChips(
                              status:
                                  dealCubit.dealLayer.deals[index].dealStatus,
                              onTap: () async {
                                await updateStatus(
                                    value: DropMenuList.dealStatus.first,
                                    context: context,
                                    title: "حالة",
                                    onChanged: (value) {},
                                    items: DropMenuList.dealStatus
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
                      const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text("المنتج"),
                      ),
                      DataColumn(
                        onSort: (columnIndex, ascending) {
                          if (ascending) {}
                        },
                        label: const Text("مدة صفقة"),
                      ),
                      const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text("عدد "),
                      ),
                      const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text("الحالة"),
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
