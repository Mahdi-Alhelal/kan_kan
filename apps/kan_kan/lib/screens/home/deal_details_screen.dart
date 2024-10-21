import 'package:flutter/material.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';

class DealDetailsScreen extends StatefulWidget {
  const DealDetailsScreen({super.key});

  @override
  State<DealDetailsScreen> createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabBar = TabController(length: 2, vsync: this);

    return Scaffold(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.calendar_month,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '100 يوم/أيام',
                          style: TextStyle(color: AppColor.white),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "تلفزيون 75 بوصة",
                    style: TextStyle(fontSize: 20, color: AppColor.primary),
                  ),
                  Text(
                    "1599 ريال",
                    style: TextStyle(fontSize: 20),
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
                  controller: _tabBar,
                  labelPadding: EdgeInsets.only(left: 20, right: 20),
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
                height: 100,
                child: TabBarView(controller: _tabBar, children: const [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: AppColor.primary,
                              ),
                              Text(
                                "البداية : ",
                                style: TextStyle(color: AppColor.primary),
                              ),
                              Text(
                                "2024/11/07",
                                style: TextStyle(color: AppColor.primary),
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
                                style: TextStyle(color: AppColor.primary),
                              ),
                              Text(
                                "2024/11/07",
                                style: TextStyle(color: AppColor.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("التوصيل :"),
                          Text("15 - 45 "),
                          Text("يوم")
                        ],
                      ),
                      Row(
                        children: [
                          Text("يتشارك عدد"),
                          Text(" 15 "),
                          Text("شخص / أشخاص في هذه الصفقة")
                        ],
                      )
                    ],
                  ),
                  Text("Hi")
                ]),
              ),
            )
          ],
        ));
  }
}
