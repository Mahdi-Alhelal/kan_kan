import 'package:flutter/material.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/screens/auth/register_screen.dart';
import 'package:kan_kan/screens/pre_payment_screen.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

class DealDetailsScreen extends StatelessWidget {
  const DealDetailsScreen({super.key, required this.dealData});
  final DealModel dealData;

  @override
  Widget build(BuildContext context) {
    String strStartDate = DateConverter.saDateFormate(dealData.startDate);
    String strEndDate = DateConverter.saDateFormate(dealData.endDate);
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.parse(dealData.endDate);

    int daysInterval =
        DateConverter.differenceInDays(endDate: endDate, startDate: startDate);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.bg,
            leading: const Icon(Icons.arrow_back),
            title: const Text("تفاصيل الصفقة"),
          ),
          body: Column(
            children: [
              Image.asset("assets/images/products-sample/tv-sample.png"),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${daysInterval} يوم/أيام',
                            style: const TextStyle(color: AppColor.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dealData.dealTitle,
                      style: TextStyle(fontSize: 20, color: AppColor.primary),
                    ),
                    Text(
                      "${dealData.totalPrice} ريال",
                      style: TextStyle(fontSize: 20, color: AppColor.secondary),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         width: context.getWidth(value: 0.45),
              //         height: 35,
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //             color: AppColor.secondary,
              //             borderRadius: BorderRadius.circular(8),
              //             border: Border.all(color: AppColor.secondary)),
              //         child: Text(
              //           "تفاصيل الصفقة",
              //           style: TextStyle(color: AppColor.white),
              //         ),
              //       ),
              //       Container(
              //         width: context.getWidth(value: 0.45),
              //         height: 35,
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //             color: AppColor.white,
              //             borderRadius: BorderRadius.circular(8),
              //             border: Border.all(color: AppColor.secondary)),
              //         child: Text("تفاصيل المنتج"),
              //       )
              //     ],
              //   ),
              // ),
              Container(
                width: context.getWidth(),
                height: 35,
                alignment: Alignment.center,
                child: TabBar(
                    // indicatorPadding: EdgeInsets.zero,
                    //tabAlignment: TabAlignment.fill,

                    labelColor: AppColor.white,
                    dividerColor: AppColor.bg,
                    indicator: BoxDecoration(
                        color: AppColor.secondary,
                        borderRadius: BorderRadius.circular(8)),
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    tabs: const [
                      const Tab(
                        text: "تفاصيل الصفقة",
                      ),
                      Tab(
                        text: "تفاصيل المنتج",
                      )
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: context.getWidth(),
                  height: 150,
                  child: TabBarView(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: AppColor.primary,
                                ),
                                const Text(
                                  "البداية : ",
                                  style: TextStyle(color: AppColor.primary),
                                ),
                                Text(
                                  strStartDate,
                                  style:
                                      const TextStyle(color: AppColor.primary),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: AppColor.primary,
                                ),
                                const Text(
                                  "النهاية : ",
                                  style: TextStyle(color: AppColor.primary),
                                ),
                                Text(
                                  strEndDate,
                                  style:
                                      const TextStyle(color: AppColor.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.local_shipping,
                              color: AppColor.primary,
                            ),
                            const Text("التوصيل :"),
                            Text(
                                "${dealData.estimateDeliveryDateFrom} - ${dealData.estimateDeliveryTimeTo} "),
                            const Text("يوم")
                          ],
                        ),
                        dealData.numberOfOrder > 0
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.handshake,
                                    color: AppColor.primary,
                                  ),
                                  const Text("يتشارك عدد"),
                                  Text(" ${dealData.numberOfOrder} "),
                                  const Text("شخص / أشخاص في هذه الصفقة")
                                ],
                              )
                            : const Row(
                                children: [
                                  const Icon(
                                    Icons.handshake,
                                    color: AppColor.primary,
                                  ),
                                  const Text("كن أنت أول شخص ينضم إلى الصفقة"),
                                ],
                              )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text("وصف المنتج : "),
                            SizedBox(
                              width: 300,
                              child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  softWrap: false,
                                  dealData.product.productDescription),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.align_vertical_center,
                                  color: AppColor.primary,
                                ),
                                const Text("الطول : "),
                                Text("${dealData.product.length} سم")
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.align_horizontal_center,
                                  color: AppColor.primary,
                                ),
                                const Text("العرض : "),
                                Text("${dealData.product.width} سم")
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.height,
                                  color: AppColor.primary,
                                ),
                                const Text("الإرتفاع : "),
                                Text("${dealData.product.height} سم")
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.line_weight,
                                  color: AppColor.primary,
                                ),
                                const Text("  الوزن : "),
                                Text("${dealData.product.wight} سم")
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: context.getWidth(value: 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.secondary),
                          child: const Icon(Icons.add),
                        ),
                        const Text("1"),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.secondary),
                          child: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: context.getWidth(value: 0.6),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrePaymentScreen()),
                          );
                        },
                        child: const Text("إنضمام إلى الصفقة")),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
