import 'package:flutter/material.dart';
import 'package:kan_kan_admin/dummy_data/status_list.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/dummy_data/deals_dummy.dart';
import 'package:kan_kan_admin/screen/src/deals_details_screen.dart';
import 'package:kan_kan_admin/widget/form/add_deal_form.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/button/add_button.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/ui.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddButton(
            onPressed: () {
              customBottomSheet(context: context, child: const AddDealForm());
            },
          ),
          TableSizedBox(
            child: CustomTableTheme(
              child: PaginatedDataTable(
                showEmptyRows: false,
                source: TableDataRow(
                  length: dealsList.length,
                  customRow: List.generate(
                    dealsList.length,
                    (index) => DataRow(
                      onLongPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DealsDetailsScreen(),
                        ),
                      ),
                      color: WidgetStateProperty.all(AppColor.white),
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Text(
                                  "${dealsList[index].productName}\n${dealsList[index].id}")
                            ],
                          ),
                        ),
                        DataCell(Text(
                            "${dealsList[index].start} الى ${dealsList[index].end}")),
                        DataCell(Text(
                            "${dealsList[index].numberOfJoined}/${dealsList[index].max}")),
                        DataCell(CustomChips(
                          status: dealsList[index].status,
                          onTap: () async {
                            await updateStatus(
                                value: DropMenuList.dealStatus.first,
                                context: context,
                                title: "حالة",
                                onChanged: (value) {},
                                items: DropMenuList.dealStatus
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
                columns: [
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("المنتج"),
                  ),
                  DataColumn(
                    onSort: (columnIndex, ascending) {
                      if (ascending) {
                        dealsList = dealsList.reversed.toList();
                      }
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
  }
}
