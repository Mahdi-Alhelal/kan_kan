import 'package:flutter/material.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:kan_kan_admin/model/order_model2.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen(
      {super.key,
      required this.orderDetails,
      required this.dealDetails,
      required this.userDetails});

  final OrderModel orderDetails;
  final DealModel dealDetails;
  final UserModel userDetails;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabBar = TabController(length: 3, vsync: this);
    //final dealTitle =

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.third),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/logo/kan_kan_logo.png",
                          width: context.getWidth(value: 0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: context.getWidth(value: 0.48),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.dealDetails.dealTitle.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                    "${widget.dealDetails.salePrice.toString()} ريال",
                                    style: const TextStyle(fontSize: 16))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                                  controller: _tabBar,
                                  labelPadding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  tabs: const [
                                    Tab(
                                      text: "تفاصيل الصفقة",
                                    ),
                                    Tab(
                                      text: "تفاصيل المنتج",
                                    ),
                                    Tab(
                                      text: "تفاصيل المصنع",
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: context.getWidth(),
                                height: 150,
                                child:
                                    TabBarView(controller: _tabBar, children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: AppColor.primary,
                                              ),
                                              Text(
                                                "البداية : ",
                                                style: TextStyle(
                                                    color: AppColor.primary),
                                              ),
                                              Text(
                                                "2024/11/07",
                                                style: TextStyle(
                                                    color: AppColor.primary),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: AppColor.primary,
                                              ),
                                              Text(
                                                "النهاية : ",
                                                style: TextStyle(
                                                    color: AppColor.primary),
                                              ),
                                              Text(
                                                "2024/11/07",
                                                style: TextStyle(
                                                    color: AppColor.primary),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.local_shipping,
                                                color: AppColor.primary,
                                              ),
                                              const Text("التوصيل :"),
                                              Text(
                                                  "${widget.dealDetails.estimateDeliveryDateFrom} - ${widget.dealDetails.estimateDeliveryTimeTo} "),
                                              const Text("يوم")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .production_quantity_limits,
                                                color: AppColor.primary,
                                              ),
                                              Text(
                                                  "${widget.dealDetails.maxOrdersPerUser} "),
                                              const Text("لكل شخص")
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.handshake,
                                            color: AppColor.primary,
                                          ),
                                          const Text("يتشارك عدد"),
                                          Text(
                                              " ${widget.dealDetails.numberOfOrder} "),
                                          const Text(
                                              "شخص / أشخاص في هذه الصفقة")
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                widget.dealDetails.product
                                                    .productDescription),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.align_vertical_center,
                                                color: AppColor.primary,
                                              ),
                                              const Text("الطول : "),
                                              Text(
                                                  "${widget.dealDetails.product.length} سم")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.align_horizontal_center,
                                                color: AppColor.primary,
                                              ),
                                              const Text("العرض : "),
                                              Text(
                                                  "${widget.dealDetails.product.width} سم")
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.height,
                                                color: AppColor.primary,
                                              ),
                                              const Text("الإرتفاع : "),
                                              Text(
                                                  "${widget.dealDetails.product.height} سم")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.line_weight,
                                                color: AppColor.primary,
                                              ),
                                              const Text("  الوزن : "),
                                              Text(
                                                  "${widget.dealDetails.product.length} سم")
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.factory,
                                                color: AppColor.primary,
                                              ),
                                              const Text("المصنع : "),
                                              Text(widget.dealDetails.product
                                                  .factory.factoryName)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.place,
                                                color: AppColor.primary,
                                              ),
                                              const Text("المنطقة :"),
                                              Text(widget.dealDetails.product
                                                  .factory.region)
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.factory,
                                                color: AppColor.primary,
                                              ),
                                              const Text("ممثل المصنع : "),
                                              Text(widget.dealDetails.product
                                                  .factory.factoryName)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone,
                                                color: AppColor.primary,
                                              ),
                                              const Text("رقم التواصل :"),
                                              Text(widget.dealDetails.product
                                                  .factory.contactPhone)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.getWidth(value: 0.48),
                      child: Image.asset(
                          "assets/images/products-sample/tv-sample.png"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: AppColor.black.withOpacity(20 / 100),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: context.getWidth(value: 0.45),
                      height: context.getHeight(value: 0.3),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.white),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("بيانات الفاتورة"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "رقم الطلب",
                                  style: TextStyle(color: AppColor.secondary),
                                ),
                                Text(
                                  "#${widget.orderDetails.orderId}",
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
                                Text("${widget.dealDetails.salePrice} ريال")
                              ],
                            ),
                            const Divider(
                              color: AppColor.bg,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("رسوم التوصيل والجمارك"),
                                Text("${widget.dealDetails.deliveryPrice} ريال")
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
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text("${widget.orderDetails.amount} ريال",
                                    style: const TextStyle(fontSize: 16))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: context.getWidth(value: 0.45),
                      height: context.getHeight(value: 0.3),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColor.white),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("بيانات العميل"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "اسم العميل",
                                  style: TextStyle(
                                      fontSize: 14, color: AppColor.secondary),
                                ),
                                Text(
                                  widget.userDetails.fullName,
                                  style: const TextStyle(
                                      fontSize: 14, color: AppColor.secondary),
                                )
                              ],
                            ),
                            const Divider(
                              color: AppColor.bg,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("رقم التواصل"),
                                Text(widget.userDetails.phone)
                              ],
                            ),
                            const Divider(
                              color: AppColor.bg,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("الإيميل"),
                                Text(widget.userDetails.email)
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
                                  "موقع العميل",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(widget.orderDetails.address,
                                    style: TextStyle(fontSize: 14))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: context.getWidth(value: 0.22),
                      height: context.getHeight(value: 0.25),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: context.getWidth(value: 0.20),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("تحديث حالة الطلب")),
                            ),
                            SizedBox(
                              width: context.getWidth(value: 0.20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("إلغاء الطلب")),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: AppColor.secondary,
                      width: context.getWidth(value: 0.75),
                      child: const Text("التتبع هنا "),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
