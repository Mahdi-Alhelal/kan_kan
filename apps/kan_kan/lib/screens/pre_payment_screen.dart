import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan/cubit/address_cubit/address_cubit.dart';
import 'package:kan_kan/cubit/payment_cubit/payment_cubit.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/screens/order_screen.dart';
import 'package:kan_kan/screens/sucess_payment_screen.dart.dart';
import 'package:kan_kan/widgets/custom_choice_chip.dart';
import 'package:moyasar/moyasar.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:lottie/lottie.dart';

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

    toDouble({required num amount}) {
      double amountDouble = amount.toDouble();
      return amountDouble;
    }

    String address = "Dammam";

    final paymentConfig = PaymentConfig(
        publishableApiKey: "pk_test_eMwVbFMRpumqb8dxpcU2fTQwv6MFavNZLPuNgjhj",
        amount: toInteger(amount: dealData.totalPrice * items),
        description: 'deal #${dealData.dealId}',
        metadata: {
          'product_name': dealData.dealTitle.toString(),
        },
        creditCard: CreditCardConfig(saveCard: false, manual: false));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.bg,
        title: const Text("صفحة الدفع"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "باقي خطوة واحدة ⏳",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
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
                      dealData.dealUrl != ""
                          ? Image.network(
                              dealData.dealUrl,
                              height: context.getWidth(value: 0.5),
                            )
                          : Image.asset(
                              "assets/images/logo/kan_kan_logo.png",
                              width: 200,
                            ),
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
                  width: context.getWidth(value: 0.85),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.white),
                  child: BlocProvider(
                    create: (context) => AddressCubit(),
                    child: Builder(builder: (context) {
                      final cubitAddress = context.read<AddressCubit>();
                      cubitAddress.fetchAddressEvent(
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
                          BlocBuilder<AddressCubit, AddressState>(
                            builder: (context, state) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      cubitAddress.addressLayer.addressUserList
                                          .length, (int index) {
                                    return Row(
                                      children: [
                                        CustomChoiceChip(
                                          title: cubitAddress.addressLayer
                                              .addressUserList[index]["city"],
                                          isSelected: cubitAddress.address ==
                                              cubitAddress.addressLayer
                                                      .addressUserList[index]
                                                  ["address_id"],
                                          onSelected: (value) {
                                            cubitAddress.updateChipEvent();
                                            cubitAddress.address = cubitAddress
                                                    .addressLayer
                                                    .addressUserList[index]
                                                ["address_id"];
                                            address = cubitAddress.addressLayer
                                                .addressUserList[index]["city"];
                                            print("-------");
                                            print(address);
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
                        ],
                      );
                    }),
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: context.getWidth(value: 0.85),
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
                                  BlocProvider(
                                    create: (context) => PaymentCubit(),
                                    child: Builder(builder: (context) {
                                      final paymentCubit =
                                          context.read<PaymentCubit>();
                                      return CreditCard(
                                        config: paymentConfig,
                                        onPaymentResult: (result) async {
                                          if (result is PaymentResponse) {
                                            switch (result.status) {
                                              case PaymentStatus.paid:
                                                final orderdetails =
                                                    await paymentCubit.addPaymentEvent(
                                                        allQuantity: dealData
                                                            .numberOfOrder,
                                                        userID:
                                                            "83efec21-2fc7-416e-9825-a86a8af3a63a",
                                                        paymentMethod: "MADA",
                                                        paymentStatus: "paid",
                                                        dealID: dealData.dealId,
                                                        address: address,
                                                        transactionID:
                                                            result.id,
                                                        amount: toDouble(
                                                            amount: dealData
                                                                    .totalPrice *
                                                                items),
                                                        quantity: items);
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SucessPaymentScreen(
                                                        orderDetails:
                                                            orderdetails,
                                                        dealDetails: dealData,
                                                      ),
                                                    ),
                                                    (Route<dynamic> route) =>
                                                        false);
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
                                        },
                                      );
                                    }),
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
