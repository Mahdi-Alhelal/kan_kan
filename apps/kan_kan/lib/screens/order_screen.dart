import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("صفحة الطلب"),
        backgroundColor: AppColor.bg,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "رقم الطلب",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("#1001",
                      style: TextStyle(
                        fontSize: 18,
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text("2024-11-07",
                  style: TextStyle(
                      fontSize: 18,
                      color: AppColor.black.withOpacity(40 / 100))),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: context.getWidth(value: 0.75),
                height: context.getHeight(value: 0.4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "رقم الصفقة",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.primary),
                        ),
                        Text(
                          "#1001",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.primary),
                        )
                      ],
                    ),
                    Image.asset("assets/images/products-sample/tv-sample.png"),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "تلفزيون 75 بوصة",
                          style:
                              TextStyle(fontSize: 16, color: AppColor.primary),
                        ),
                        Text(
                          "2x",
                          style: TextStyle(
                              fontSize: 16, color: AppColor.secondary),
                        )
                      ],
                    ),
                    const Divider(
                      color: AppColor.bg,
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
              SizedBox(
                height: 20,
              ),
              Container(
                width: context.getWidth(value: 0.75),
                height: context.getHeight(value: 0.4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.white),
                child: Column(
                  children: [Text("رقم التتبع #قريباً")],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
