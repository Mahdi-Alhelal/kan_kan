import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/cubits/order_cubit/order_cubit.dart';
import 'package:kan_kan_admin/local_data/status_list.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
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
      Text("قيد الانتظار"),
      Text("قيد المعالجة"),
      Text("في الصين"),
      Text("قيد النقل"),
      Text("في سعودية"),
      Text("مع شركة الشحن"),
      Text("مكتمل"),
      Text("ملغى")
    ];
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: Builder(builder: (context) {
        final orderCubit = context.read<OrderCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ToggleButtons(
                      onPressed: (value) => orderCubit.onToggleEvent(value),
                      isSelected: orderCubit.selected,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedColor: AppColor.white,
                      fillColor: AppColor.primary,
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 150.0,
                      ),
                      children: filters,
                    ),
                  );
                },
              ),
              TableSizedBox(
                child: CustomTableTheme(
                  child: BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (orderCubit.ordersData.orders.isNotEmpty &&
                          orderCubit.userOrderDeal.deals.isNotEmpty) {
                        return PaginatedDataTable(
                          sortAscending: orderCubit.sort,
                          sortColumnIndex: orderCubit.columnIndex,
                          showEmptyRows: false,
                          source: TableDataRow(
                            length: orderCubit.filteredOrder.length,
                            customRow: List.generate(
                                orderCubit.filteredOrder.length, (index) {
                              UserModel orderUser = orderCubit.userOrderData
                                  .getOrderUser(
                                      id: orderCubit
                                          .filteredOrder[index].userId);

                              DealModel myDeal = orderCubit.userOrderDeal.deals
                                  .firstWhere((element) =>
                                      element.dealId ==
                                      orderCubit.filteredOrder[index].dealId);

                              orderCubit.userOrderProduct.getProductOrder(
                                  id: myDeal.product.productId);

                              return DataRow(
                                onLongPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetailsScreen(
                                          orderDetails:
                                              orderCubit.filteredOrder[index],
                                          dealDetails: myDeal,
                                          userDetails: orderUser),
                                    ),
                                  ).then((_) {
                                    orderCubit.getNewOrder();
                                    orderCubit.getNewUser();
                                    orderCubit.sortEvent();
                                  });
                                },
                                color: WidgetStateProperty.all(AppColor.white),
                                cells: [
                                  DataCell(
                                    Row(
                                      children: [
                                        Text(
                                            "${orderUser.fullName}\n O${orderCubit.filteredOrder[index].orderId}")
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(
                                      "${orderCubit.filteredOrder[index].amount}")),
                                  DataCell(Text(myDeal.dealTitle)),
                                  DataCell(Text(DateConverter.usDateFormate(
                                      orderCubit
                                          .filteredOrder[index].orderDate))),
                                  DataCell(
                                    CustomChips(
                                      //Todo: link with paymentStatus
                                      statusColor: orderCubit.ordersData
                                          .orders[index].paymentStatus,
                                      status: orderCubit.ordersData
                                          .orders[index].paymentStatus,
                                      onTap: () async {
                                        await updateStatus(
                                            value: orderCubit.ordersData
                                                .orders[index].paymentStatus,
                                            context: context,
                                            title: "حالة",
                                            onChanged: (value) {},
                                            items: DropMenuList.paymentStatus
                                                .map<DropdownMenuItem>(
                                                    (String status) {
                                              return DropdownMenuItem(
                                                value: status,
                                                child: Text(status).tr(),
                                              );
                                            }).toList());
                                      },
                                    ),
                                  ),
                                  DataCell(CustomChips(
                                    statusColor: orderCubit
                                        .filteredOrder[index].orderStatus,
                                    status: orderCubit
                                        .filteredOrder[index].orderStatus,
                                    onTap: () async {
                                      await updateStatus(
                                          onPressed: () {
                                            orderCubit.updateUserOrderStatus(
                                                index: index);
                                          },
                                          value: orderCubit.ordersData
                                              .orders[index].orderStatus,
                                          context: context,
                                          title: "حالة",
                                          onChanged: (value) {
                                            orderCubit.tmpUserOrderStatus =
                                                value;
                                          },
                                          items: DropMenuList.shipmentStatus
                                              .map<DropdownMenuItem>(
                                                  (String status) {
                                            return DropdownMenuItem(
                                              value: status,
                                              child: Text(status).tr(),
                                            );
                                          }).toList());
                                    },
                                  )),
                                ],
                              );
                            }),
                          ),
                          columns: [
                            DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: const Text("العميل"),
                              onSort: (columnIndex, ascending) {
                                if (orderCubit.sort) {
                                  orderCubit.filteredOrder.sort(
                                      (a, b) => a.orderId.compareTo(b.orderId));
                                } else {
                                  orderCubit.filteredOrder.sort(
                                      (a, b) => b.orderId.compareTo(a.orderId));
                                }
                                orderCubit.sort = !orderCubit.sort;
                                orderCubit.columnIndex = columnIndex;
                                orderCubit.sortEvent();
                              },
                            ),
                            DataColumn(
                              onSort: (columnIndex, ascending) {
                                if (orderCubit.sort) {
                                  orderCubit.filteredOrder.sort(
                                      (a, b) => a.amount.compareTo(b.amount));
                                } else {
                                  orderCubit.filteredOrder.sort(
                                      (a, b) => b.amount.compareTo(a.amount));
                                }
                                orderCubit.sort = !orderCubit.sort;
                                orderCubit.columnIndex = columnIndex;
                                orderCubit.sortEvent();
                              },
                              label: const Text("السعر"),
                            ),
                            DataColumn(
                                headingRowAlignment: MainAxisAlignment.center,
                                label: const Text("الصفقة"),
                                onSort: (columnIndex, ascending) {
                                  //Todo: test sort by deal title
                                  if (orderCubit.sort) {
                                    orderCubit.filteredOrder.sort(
                                      (a, b) => orderCubit.userOrderDeal
                                          .findDeal(a.dealId)
                                          .dealTitle
                                          .compareTo(orderCubit.userOrderDeal
                                              .findDeal(b.dealId)
                                              .dealTitle),
                                    );
                                  } else {
                                    orderCubit.filteredOrder.sort(
                                      (a, b) => orderCubit.userOrderDeal
                                          .findDeal(b.dealId)
                                          .dealTitle
                                          .compareTo(orderCubit.userOrderDeal
                                              .findDeal(a.dealId)
                                              .dealTitle),
                                    );
                                  }
                                  orderCubit.sort = !orderCubit.sort;
                                  orderCubit.columnIndex = columnIndex;
                                  orderCubit.sortEvent();
                                }),
                            DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: const Text("تاريخ طلب"),
                              onSort: (columnIndex, ascending) {
                                if (orderCubit.sort) {
                                  orderCubit.filteredOrder.sort(
                                    (a, b) =>
                                        DateTime.parse(a.orderDate).compareTo(
                                      DateTime.parse(b.orderDate),
                                    ),
                                  );
                                } else {
                                  orderCubit.filteredOrder.sort(
                                    (a, b) =>
                                        DateTime.parse(b.orderDate).compareTo(
                                      DateTime.parse(a.orderDate),
                                    ),
                                  );
                                }
                                orderCubit.sort = !orderCubit.sort;
                                orderCubit.columnIndex = columnIndex;
                                orderCubit.sortEvent();
                              },
                            ),
                            DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: const Text("حالة الدفع"),
                              onSort: (columnIndex, ascending) {
                                if (orderCubit.sort) {
                                  orderCubit.filteredOrder.sort((a, b) =>
                                      a.orderStatus.compareTo(b.orderStatus));
                                } else {
                                  orderCubit.filteredOrder.sort((a, b) =>
                                      b.orderStatus.compareTo(a.orderStatus));
                                }
                                orderCubit.sort = !orderCubit.sort;
                                orderCubit.columnIndex = columnIndex;
                                orderCubit.sortEvent();
                              },
                            ),
                            const DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text("حالة"),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
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
