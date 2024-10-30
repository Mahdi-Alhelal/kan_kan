import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kan_kan/cubit/address_cubit/address_cubit.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/screens/order_screen.dart';
import 'package:kan_kan/screens/sucess_payment_screen.dart.dart';
import 'package:kan_kan/widgets/custom_choice_chip.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';

class PrePaymentScreen extends StatelessWidget {
  const PrePaymentScreen(
      {super.key, required this.dealData, required this.items});
  final DealModel dealData;
  final int items;

  @override
  Widget build(BuildContext context) {
    toInteger({required num amount}) {
      int amountInt = (amount * 100).toInt();
      return amountInt;
    }

    final paymentConfig = PaymentConfig(
        publishableApiKey: "pk_test_eMwVbFMRpumqb8dxpcU2fTQwv6MFavNZLPuNgjhj",
        amount: toInteger(amount: dealData.totalPrice * items), // SAR 257.58
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.white),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "رقم الصفقة",
                            style: TextStyle(
                                fontSize: 20, color: AppColor.primary),
                          ),
                          Text(
                            "#${dealData.dealId}",
                            style: const TextStyle(
                                fontSize: 20, color: AppColor.primary),
                          )
                        ],
                      ),
                      Image.asset(
                          "assets/images/products-sample/tv-sample.png"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dealData.dealTitle,
                            style: const TextStyle(
                                fontSize: 20, color: AppColor.primary),
                          ),
                          Text(
                            "${items}x",
                            style: const TextStyle(
                                fontSize: 20, color: AppColor.secondary),
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
                          Text("${dealData.salePrice * items} ريال")
                        ],
                      ),
                      const Divider(
                        color: AppColor.bg,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("رسوم التوصيل والجمارك"),
                          Text("${dealData.deliveryPrice * items} ريال")
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
                          Text("${dealData.totalPrice * items} ريال",
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
              Container(
                  width: context.getWidth(value: 0.75),
                  height: context.getHeight(value: 0.15),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.white),
                  child: BlocProvider(
                    create: (context) => AddressCubit(),
                    child: Builder(builder: (context) {
                      final address_cubit = context.read<AddressCubit>();
                      address_cubit.fetchAddressEvent(
                          userID: "83efec21-2fc7-416e-9825-a86a8af3a63a");
                      return Column(
                        children: [
                          Text(
                            "المنطقة",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //dropdownList
                          //CustomTextField(title: "المنطقة"),
                          BlocBuilder<AddressCubit, AddressState>(
                            builder: (context, state) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      address_cubit.addressLayer.addressUserList
                                          .length, (int index) {
                                    return Row(
                                      children: [
                                        CustomChoiceChip(
                                          title: address_cubit.addressLayer
                                              .addressUserList[index]["city"],
                                          isSelected: address_cubit.address ==
                                              address_cubit.addressLayer
                                                      .addressUserList[index]
                                                  ["address_id"],
                                          onSelected: (value) {
                                            address_cubit.updateChipEvent();
                                            address_cubit.address =
                                                address_cubit.addressLayer
                                                        .addressUserList[index]
                                                    ["address_id"];
                                            print(address_cubit.address);
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                          // CustomChoiceChip(title: "aaa", isSelected: true),
                          // CustomChoiceChip(title: "bbb", isSelected: false),
                          // CustomChoiceChip(title: "ccc", isSelected: false)
                        ],
                      );
                    }),
                  )),
              const SizedBox(
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
                          height: context.getHeight(value: 0.55),
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
                  child: const Text("إدفع الآن"),
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderScreen()),
                    );
                  },
                  child: const Text("تجربة"))
            ],
          ),
        ),
      ),
    );
  }
}
