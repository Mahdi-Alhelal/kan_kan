import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/model/order_model.dart';
import 'package:kan_kan/screens/order_screen.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';

class SucessPaymentScreen extends StatelessWidget {
  const SucessPaymentScreen(
      {super.key, required this.orderDetails, required this.dealDetails});
  final OrderModel orderDetails;
  final DealModel dealDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: context.getWidth(value: 0.75),
                height: context.getHeight(value: 0.6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "رقم الطلب : ${orderDetails.orderId}#",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              const Color(0xff23A26D).withOpacity(12 / 100),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff23A26D),
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 35,
                            weight: 30,
                            shadows: [
                              Shadow(blurRadius: 3, color: AppColor.white)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "تمت عملية الدفع بنجاح",
                      style: TextStyle(color: AppColor.secondary, fontSize: 20),
                    ),
                    const Divider(
                      color: AppColor.bg,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dealDetails.dealTitle,
                          style: const TextStyle(
                              fontSize: 14, color: AppColor.primary),
                        ),
                        Text(
                          orderDetails.quantity.toString(),
                          style: const TextStyle(
                              fontSize: 14, color: AppColor.primary),
                        )
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
                          "رقم الصفقة",
                          style:
                              TextStyle(fontSize: 14, color: AppColor.primary),
                        ),
                        Text(
                          "#${dealDetails.dealId}",
                          style: const TextStyle(
                              fontSize: 14, color: AppColor.primary),
                        )
                      ],
                    ),
                    const Divider(
                      color: AppColor.bg,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("السعر"),
                        Text(
                            "${dealDetails.salePrice * orderDetails.quantity} ريال")
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: context.getWidth(value: 0.75),
                height: 50,
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
                  child: const Text("تفاصيل الطلب"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: context.getWidth(value: 0.75),
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: const Text("الإطلاع على صفقات آخرى"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
