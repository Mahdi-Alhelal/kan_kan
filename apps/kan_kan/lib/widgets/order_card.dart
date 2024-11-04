import 'package:flutter/material.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/model/order_model.dart';
import 'package:kan_kan/screens/order_screen.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key, required this.orderDetails, required this.dealDetails});
  final OrderModel orderDetails;
  final DealModel dealDetails;
  @override
  Widget build(BuildContext context) {
    String strStatus = orderDetails.orderStatus;
    OrderStatus enumOrder = EnumOrderHelper.stringToOrderStatus(strStatus);
    String languageCode = Localizations.localeOf(context).languageCode;

    String status = LocalizedEnums.getOrderStatusName(enumOrder, languageCode);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.getWidth(value: 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.getWidth(value: 0.3),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("#${orderDetails.orderId}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dealDetails.dealTitle),
                            Text("${orderDetails.quantity}x")
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: context.getWidth(value: 0.2),
                    child: Image.asset(
                      "assets/images/products-sample/tv-sample.png",
                      width: 150,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: context.getWidth(value: 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("حالة الطلب"),
                  Text(
                    status,
                    style:
                        TextStyle(fontSize: 10, color: getEnumColor(enumOrder)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: context.getWidth(value: 0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("السعر الاجمالي"),
                  Text(orderDetails.amount.toString())
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: context.getWidth(value: 0.4),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderScreen(
                                  orderDetails: orderDetails,
                                  dealDetails: dealDetails,
                                )),
                      );
                    },
                    child: const Text("تفاصيل الطلب"))),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
