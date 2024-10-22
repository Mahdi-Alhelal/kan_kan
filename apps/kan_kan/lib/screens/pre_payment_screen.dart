import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';

class PrePaymentScreen extends StatelessWidget {
  const PrePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentConfig = PaymentConfig(
        publishableApiKey: "pk_test_eMwVbFMRpumqb8dxpcU2fTQwv6MFavNZLPuNgjhj",
        amount: 25758, // SAR 257.58
        description: 'order #1324',
        metadata: {'size': '250g'},
        creditCard: CreditCardConfig(saveCard: true, manual: false));
    void onPaymentResult(result) {
      if (result is PaymentResponse) {
        switch (result.status) {
          case PaymentStatus.paid:
            // handle success.
            break;
          case PaymentStatus.failed:
            // handle failure.
            break;
          case PaymentStatus.initiated:
          // TODO: Handle this case.
          case PaymentStatus.authorized:
          // TODO: Handle this case.
          case PaymentStatus.captured:
          // TODO: Handle this case.
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bg,
        leading: const Icon(Icons.arrow_back),
        title: const Text("صفحة الدفع"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "باقي خطوة واحدة :)",
              style: TextStyle(fontSize: 20),
            ),
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "رقم الصفقة",
                        style: TextStyle(fontSize: 20, color: AppColor.primary),
                      ),
                      Text(
                        "#1001",
                        style: TextStyle(fontSize: 20, color: AppColor.primary),
                      )
                    ],
                  ),
                  Image.asset("assets/images/products-sample/tv-sample.png"),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "تلفزيون 75 بوصة",
                        style: TextStyle(fontSize: 20, color: AppColor.primary),
                      ),
                      Text(
                        "2x",
                        style:
                            TextStyle(fontSize: 20, color: AppColor.secondary),
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
                    children: [Text("رسوم التوصيل والجمارك"), Text("300 ريال")],
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
                        style:
                            TextStyle(color: AppColor.secondary, fontSize: 16),
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
            SizedBox(
              width: context.getWidth(value: 0.75),
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    backgroundColor: AppColor.white,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: context.getHeight(value: 0.5),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CreditCard(
                                  config: paymentConfig,
                                  onPaymentResult: onPaymentResult,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text("إدفع الآن"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
