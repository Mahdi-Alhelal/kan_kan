import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/cubits/order_cubit/order_cubit.dart';
import 'package:kan_kan_admin/dummy_data/status_list.dart';
import 'package:kan_kan_admin/helper/order_enums.dart';
import 'package:kan_kan_admin/helper/payment_enums.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:kan_kan_admin/model/product_model.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:kan_kan_admin/screen/src/order_details_screen.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
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
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: Builder(builder: (context) {
        final orderCubit = context.read<OrderCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToggleButtons(
                onPressed: (value) async {},
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
                    source: TableDataRow(
                      length: orderCubit.ordersData.orders.length,
                      customRow: List.generate(
                          orderCubit.ordersData.orders.length, (index) {
                        UserModel orderUser = orderCubit.userOrderData
                            .getOrderUser(
                                id: orderCubit.ordersData.orders[index].userId);
                        DealModel orderDeal = orderCubit.userOrderDeal
                            .getProductDeal(
                                id: orderCubit.ordersData.orders[index].dealId);
                        ProductModel orderProduct = orderCubit.userOrderProduct
                            .getProductOrder(id: orderDeal.product.productId);
                        String languageCode =
                            Localizations.localeOf(context).languageCode;

                        OrderStatus orderStatus =
                            EnumOrderHelper.stringToOrderStatus(orderCubit
                                .ordersData.orders[index].orderStatus);
                        String localizedOrderStatus =
                            LocalizedEnums.getOrderStatusName(
                                orderStatus, languageCode);

                        PaymentEnums paymentStatus =
                            EnumPaymentHelper.stringToOrderStatus(orderCubit
                                .ordersData.orders[index].orderStatus);
                        String localizedPaymentStatus =
                            LocalizedPaymentEnums.getPaymentStatusName(
                                paymentStatus, languageCode);

                        return DataRow(
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailsScreen(
                                      orderDetails:
                                          orderCubit.ordersData.orders[index],
                                      dealDetails: orderDeal,
                                      userDetails: orderUser)),
                            );
                          },
                          color: WidgetStateProperty.all(AppColor.white),
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  Text(
                                      "${orderUser.fullName}\n O${orderCubit.ordersData.orders[index].orderId}")
                                ],
                              ),
                            ),
                            DataCell(Text(
                                "${orderCubit.ordersData.orders[index].amount}")),
                            DataCell(Text(orderProduct.productName)),
                            DataCell(Text(DateConverter.usDateFormate(orderCubit
                                .ordersData.orders[index].orderDate))),
                            DataCell(CustomChips(
                              //orderCubit.ordersData.orders[index].orderStatus

                              status: localizedPaymentStatus,
                              onTap: () async {
                                await updateStatus(
                                    value: DropMenuList.paymentStatus.first,
                                    context: context,
                                    title: "حالة",
                                    onChanged: (value) {},
                                    items: DropMenuList.paymentStatus
                                        .map<DropdownMenuEntry<String>>(
                                            (String status) {
                                      return DropdownMenuEntry(
                                        value: status,
                                        label: status,
                                      );
                                    }).toList());
                              },
                            )),
                            DataCell(CustomChips(
                              status: localizedOrderStatus,
                              onTap: () async {
                                await updateStatus(
                                    value: DropMenuList.shipmentStatus.first,
                                    context: context,
                                    title: "حالة",
                                    onChanged: (value) {},
                                    items: DropMenuList.shipmentStatus
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
                        );
                      }),
                    ),
                    columns: [
                      const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Text("العميل"),
                      ),
                      DataColumn(
                        onSort: (columnIndex, ascending) {
                          if (ascending) {
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
      }),
    );
  }
}
