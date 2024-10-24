import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabBar = TabController(length: 3, vsync: this);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColor.primary,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "تلفزيون 75 بوصة",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text("2000 ريال", style: TextStyle(fontSize: 16))
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
                                labelPadding:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                              child: TabBarView(
                                  controller: _tabBar,
                                  children: const [
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
                                                Icon(
                                                  Icons.local_shipping,
                                                  color: AppColor.primary,
                                                ),
                                                Text("التوصيل :"),
                                                Text("15 - 45 "),
                                                Text("يوم")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .production_quantity_limits,
                                                  color: AppColor.primary,
                                                ),
                                                Text(" 2 "),
                                                Text("عدد لكل شخص")
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.handshake,
                                              color: AppColor.primary,
                                            ),
                                            Text("يتشارك عدد"),
                                            Text(" 15 "),
                                            Text("شخص / أشخاص في هذه الصفقة")
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
                                            Text("وصف المنتج : "),
                                            SizedBox(
                                              width: 300,
                                              child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                  softWrap: false,
                                                  "تلفزيون زين وحلو ورخيص وتلاقي فيهتلفزيون زين وحلو ورخيص وتلاقي فيه"),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.align_vertical_center,
                                                  color: AppColor.primary,
                                                ),
                                                Text("الطول : "),
                                                Text("100 سم")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.align_horizontal_center,
                                                  color: AppColor.primary,
                                                ),
                                                Text("العرض : "),
                                                Text("100 سم")
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.height,
                                                  color: AppColor.primary,
                                                ),
                                                Text("الإرتفاع : "),
                                                Text("100 سم")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.line_weight,
                                                  color: AppColor.primary,
                                                ),
                                                Text("  الوزن : "),
                                                Text("100 سم")
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
                                                Icon(
                                                  Icons.factory,
                                                  color: AppColor.primary,
                                                ),
                                                Text("المصنع : "),
                                                Text("Something factory")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.place,
                                                  color: AppColor.primary,
                                                ),
                                                Text("المنطقة :"),
                                                Text("Ganzo")
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
                                                Icon(
                                                  Icons.factory,
                                                  color: AppColor.primary,
                                                ),
                                                Text("ممثل المصنع : "),
                                                Text("Ali Sami")
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: AppColor.primary,
                                                ),
                                                Text("رقم التواصل :"),
                                                Text("+966597555447")
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
                    child: const SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("بيانات الفاتورة"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "رقم الطلب",
                                style: TextStyle(color: AppColor.secondary),
                              ),
                              Text(
                                "#1001",
                                style: TextStyle(
                                    fontSize: 16, color: AppColor.secondary),
                              )
                            ],
                          ),
                          Divider(
                            color: AppColor.bg,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("السعر"), Text("1399 ريال")],
                          ),
                          Divider(
                            color: AppColor.bg,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("رسوم التوصيل والجمارك"),
                              Text("300 ريال")
                            ],
                          ),
                          Divider(
                            color: AppColor.bg,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "الإجمالي",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text("2000 ريال", style: TextStyle(fontSize: 16))
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
                    child: const SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("بيانات العميل"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "اسم العميل",
                                style: TextStyle(
                                    fontSize: 14, color: AppColor.secondary),
                              ),
                              Text(
                                "علي التاروتي",
                                style: TextStyle(
                                    fontSize: 14, color: AppColor.secondary),
                              )
                            ],
                          ),
                          Divider(
                            color: AppColor.bg,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("رقم التواصل"),
                              Text("+966597555447")
                            ],
                          ),
                          Divider(
                            color: AppColor.bg,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("الإيميل"),
                              Text("tarooti14@gmail.com")
                            ],
                          ),
                          Divider(
                            color: AppColor.bg,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "موقع العميل",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text("جزيرة تاروت",
                                  style: TextStyle(fontSize: 14))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.getWidth(value: 0.25),
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
                                child: Text("تحديث حالة الطلب")),
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
                                child: Text("إلغاء الطلب")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: AppColor.secondary,
                    width: context.getWidth(value: 0.75),
                    child: Text("التتبع هنا "),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
