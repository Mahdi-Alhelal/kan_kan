import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan/cubit/order_cubit/order_cubit.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/model/order_model.dart';
import 'package:lottie/lottie.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';
import 'dart:ui' as ui;

class OrderScreen extends StatelessWidget {
  const OrderScreen(
      {super.key, required this.orderDetails, required this.dealDetails});
  final OrderModel orderDetails;
  final DealModel dealDetails;

  @override
  Widget build(BuildContext context) {
    final orderID = orderDetails.orderId;
    String orderDate = DateConverter.saDateFormate(orderDetails.orderDate);
    String? orderDateToTime = DateConverter.formatTime(orderDetails.orderDate);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("صفحة الطلب"),
        backgroundColor: AppColor.bg,
      ),
      body: BlocProvider(
        create: (context) => OrderCubit(),
        child: Builder(builder: (context) {
          final cubitOrder = context.read<OrderCubit>();
          cubitOrder.getOneOrderUser(
            orderID: orderID,
          );
          cubitOrder.getOneOrderAllTracking(orderID: orderID);

          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Lottie.asset('assets/animation/order.json',
                      width: context.getWidth(value: 0.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "رقم الطلب",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("#${orderDetails.orderId}",
                          style: const TextStyle(
                            fontSize: 18,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("$orderDate ",
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColor.black.withOpacity(40 / 100))),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: context.getWidth(value: 0.85),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.white),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "رقم الصفقة",
                                style: TextStyle(
                                    fontSize: 16, color: AppColor.primary),
                              ),
                              Text(
                                "#${orderDetails.dealId}",
                                style: const TextStyle(
                                    fontSize: 16, color: AppColor.primary),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          dealDetails.dealUrl != ""
                              ? Image.network(dealDetails.dealUrl)
                              : Image.asset(
                                  "assets/images/logo/kan_kan_logo.png",
                                  width: 200,
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dealDetails.dealTitle,
                                style: const TextStyle(
                                    fontSize: 16, color: AppColor.primary),
                              ),
                              Text(
                                "${orderDetails.quantity}x",
                                style: const TextStyle(
                                    fontSize: 16, color: AppColor.secondary),
                              )
                            ],
                          ),
                          const Divider(
                            color: AppColor.bg,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("السعر"),
                              Text(
                                  "${orderDetails.quantity * dealDetails.salePrice} ريال")
                            ],
                          ),
                          const Divider(
                            color: AppColor.bg,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("رسوم التوصيل والجمارك"),
                              Text(
                                  "${dealDetails.deliveryPrice * orderDetails.quantity} ريال")
                            ],
                          ),
                          const Divider(
                            color: AppColor.bg,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "الإجمالي",
                                style: TextStyle(
                                    color: AppColor.secondary, fontSize: 16),
                              ),
                              Text("${orderDetails.amount} ريال",
                                  style: const TextStyle(
                                      color: AppColor.secondary, fontSize: 16))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    "تتبع الطلب",
                    style: TextStyle(fontSize: 16),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: context.getWidth(value: 0.85),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.white),
                      child: StreamBuilder<List<Map<String, dynamic>>>(
                          stream: cubitOrder.getOneOrderAllTracking(
                              orderID: orderDetails.orderId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data!;
                              String languageCode =
                                  Localizations.localeOf(context).languageCode;

                              return Column(
                                  children: List.generate(data.length, (index) {
                                String strStatus = data[index]["status"];
                                OrderStatus enumOrder =
                                    EnumOrderHelper.stringToOrderStatus(
                                        strStatus);
                                String status =
                                    LocalizedEnums.getOrderStatusName(
                                        enumOrder, languageCode);
                                String strUpdateDateStatus =
                                    DateConverter.saDateFormate(
                                        data[index]["created_at"]);
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: getEnumColor(enumOrder),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          status,
                                          style: const TextStyle(
                                              color: AppColor.white),
                                        ),
                                      ),
                                      Text(strUpdateDateStatus)
                                    ],
                                  ),
                                );
                              }));
                            }
                            return const SizedBox();
                          })),
                  SizedBox(
                    height: 10,
                  ),
                  orderDetails.orderStatus == "pending"
                      ? BlocBuilder<OrderCubit, OrderState>(
                          builder: (context, state) {
                            if (state is SuccesCanceledOrderState) {
                              return SizedBox();
                            }
                            return SizedBox(
                              width: context.getWidth(value: 0.85),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () async {
                                    print("----------here");
                                    await cubitOrder.cancelOrder(
                                        orderID: orderID,
                                        dealID: orderID,
                                        quantity: orderDetails.quantity);
                                    print("----------Done");
                                  },
                                  child: Text("إلغاء الطلب")),
                            );
                          },
                        )
                      : SizedBox()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
