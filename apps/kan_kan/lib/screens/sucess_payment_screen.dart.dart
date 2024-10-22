import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';

class SucessPaymentScreen extends StatelessWidget {
  const SucessPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: context.getWidth(value: 0.75),
                height: context.getHeight(value: 0.5),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.white),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "رقم الطلب : 1002",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
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
                      height: 20,
                    ),
                    const Text(
                      "تمت عملية الدفع بنجاح",
                      style: TextStyle(color: AppColor.secondary, fontSize: 20),
                    ),
                    const Divider(
                      color: AppColor.bg,
                      thickness: 1,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "تلفزيون 75 بوصة",
                          style:
                              TextStyle(fontSize: 14, color: AppColor.primary),
                        ),
                        Text(
                          "2x",
                          style:
                              TextStyle(fontSize: 14, color: AppColor.primary),
                        )
                      ],
                    ),
                    const Divider(
                      color: AppColor.bg,
                      thickness: 1,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "رقم الصفقة",
                          style:
                              TextStyle(fontSize: 14, color: AppColor.primary),
                        ),
                        Text(
                          "#1001",
                          style:
                              TextStyle(fontSize: 14, color: AppColor.primary),
                        )
                      ],
                    ),
                    const Divider(
                      color: AppColor.bg,
                      thickness: 1,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("السعر"), Text("1399 ريال")],
                    ),
                    const Divider(
                      color: AppColor.bg,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("رسوم التوصيل والجمارك"),
                        Text("300 ريال")
                      ],
                    ),
                    const Divider(
                      color: AppColor.bg,
                      thickness: 1,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الإجمالي",
                          style: TextStyle(
                              color: AppColor.secondary, fontSize: 16),
                        ),
                        Text("2000 ريال",
                            style: TextStyle(
                                color: AppColor.secondary, fontSize: 16))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: context.getWidth(value: 0.75),
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("الإطلاع على صفقات آخرى"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
