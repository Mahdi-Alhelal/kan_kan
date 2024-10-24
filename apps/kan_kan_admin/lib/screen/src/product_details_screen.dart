import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabBar = TabController(length: 2, vsync: this);

    return SafeArea(
      child: Scaffold(
        body: Column(
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
                                        children: [
                                          Text("وصف المنتج : "),
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                                overflow: TextOverflow.ellipsis,
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
          ],
        ),
      ),
    );
  }
}
