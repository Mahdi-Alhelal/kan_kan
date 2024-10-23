import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/dummy_data/order_dummy.dart';
import 'package:kan_kan_admin/widget/chip/factory_status.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/ui.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> filters = const [
      Text("كل"),
      Text("مكتمل"),
      Text("تم إرسال الطلب"),
      Text("في مستودع الصين"),
      Text("في الشحن"),
      Text("في سعودية"),
      Text("ملغى")
    ];
    List<bool> selected = const [
      true,
      false,
      false,
      false,
      false,
      false,
      false
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToggleButtons(
            onPressed: (value) {},
            isSelected: selected,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedColor: AppColor.white,
            fillColor: AppColor.primary,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 110.0,
            ),
            children: filters,
          ),
          TableSizedBox(
            child: CustomTableTheme(
              child: PaginatedDataTable(
                showEmptyRows: false,
                headingRowColor: const WidgetStatePropertyAll(AppColor.white),
                source: TableDataRow(
                  length: orderList.length,
                  customRow: List.generate(
                    orderList.length,
                    (index) => DataRow(
                      color: WidgetStateProperty.all(AppColor.white),
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Text(
                                  "${orderList[index].customerName}\n${orderList[index].orderNumber}")
                            ],
                          ),
                        ),
                        DataCell(Text("${orderList[index].price}")),
                        DataCell(Text(orderList[index].product)),
                        DataCell(Text(orderList[index].orderDate)),
                        DataCell(CustomChips(status: orderList[index].status)),
                        DataCell(CustomChips(
                            status: orderList[index].shipmentStatus)),
                      ],
                    ),
                  ),
                ),
                columns: [
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("العميل"),
                  ),
                  DataColumn(
                    onSort: (columnIndex, ascending) {
                      if (ascending) {
                        orderList = orderList.reversed.toList();
                      }
                    },
                    label: const Text("السعر"),
                  ),
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("المنتج"),
                  ),
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("تاريخ طلب"),
                  ),
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("حالة الدفع"),
                  ),
                  const DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text("حالة"),
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
