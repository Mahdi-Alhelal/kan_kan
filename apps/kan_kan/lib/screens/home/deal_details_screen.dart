import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan/cubit/deal_deatails_cubit/deal_details_cubit.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:kan_kan/screens/auth/login_screen.dart';
import 'package:kan_kan/screens/pre_payment_screen.dart';
import 'package:kan_kan/widgets/alert.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/ui.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DealDetailsScreen extends StatelessWidget {
  const DealDetailsScreen({super.key, required this.dealData});
  final DealModel dealData;

  @override
  Widget build(BuildContext context) {
    String strStartDate = DateConverter.saDateFormate(dealData.startDate);
    String strEndDate = DateConverter.saDateFormate(dealData.endDate);
    DateTime endDate = DateTime.parse(dealData.endDate);
    String languageCode = Localizations.localeOf(context).languageCode;
    DealEnums dealStatus =
        EnumDealsHelper.stringToDealStatus(dealData.dealStatus);
    String localizedDealStatus =
        LocalizedDealsEnums.getDealsStatusName(dealStatus, languageCode);

    Widget daysInterval = DateConverter.differenceInDays(
      endDate: endDate.toString(),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.bg,
            title: const Center(child: Text("تفاصيل الصفقة")),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                dealData.product.imgList.isNotEmpty
                    ? SizedBox(
                        child: CarouselSlider(
                          items: dealData.product.imgList
                              .map((element) => Image.network(element))
                              .toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              height: context.getWidth(value: 0.5),
                              enableInfiniteScroll: false),
                        ),
                      )
                    : Image.asset(
                        "assets/images/logo/kan_kan_logo.png",
                        width: context.getWidth(value: 0.5),
                        height: context.getHeight(value: 0.3),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Row(
                    children: [
                      dealData.dealStatus != "active"
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 2),
                                decoration: BoxDecoration(
                                  color: getEnumColor(dealStatus),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  localizedDealStatus,
                                  style: const TextStyle(color: AppColor.white),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 2),
                              child: daysInterval,
                            )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dealData.dealTitle,
                        style: const TextStyle(
                            fontSize: 20, color: AppColor.primary),
                      ),
                      Text(
                        "${dealData.totalPrice} ريال",
                        style: const TextStyle(
                            fontSize: 20, color: AppColor.secondary),
                      )
                    ],
                  ),
                ),
                Container(
                  width: context.getWidth(),
                  height: 35,
                  alignment: Alignment.centerRight,
                  child: TabBar(
                      indicatorPadding:
                          const EdgeInsets.only(left: -40, right: -40),
                      labelColor: AppColor.white,
                      dividerColor: AppColor.bg,
                      indicator: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(8)),
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      tabs: const [
                        Tab(
                          text: "تفاصيل الصفقة",
                        ),
                        Tab(
                          text: "تفاصيل المنتج",
                        )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "البداية : ",
                                    style: TextStyle(color: AppColor.primary),
                                  ),
                                  Text(
                                    strStartDate,
                                    style: const TextStyle(
                                        color: AppColor.primary),
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "النهاية : ",
                                    style: TextStyle(color: AppColor.primary),
                                  ),
                                  Text(
                                    strEndDate,
                                    style: const TextStyle(
                                        color: AppColor.primary),
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
                              const SizedBox(
                                width: 5,
                              ),
                              const Text("التوصيل :"),
                              Text(
                                  "${dealData.estimateDeliveryDateFrom} - ${dealData.estimateDeliveryTimeTo} "),
                              const Text("يوم")
                            ],
                          ),
                          dealData.numberOfOrder > 0
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.handshake,
                                        color: AppColor.primary,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text("يتشارك عدد"),
                                      Text(" ${dealData.numberOfOrder} "),
                                      const Text("شخص / أشخاص في هذه الصفقة")
                                    ],
                                  ),
                                )
                              : const Row(
                                  children: [
                                    Icon(
                                      Icons.handshake,
                                      color: AppColor.primary,
                                    ),
                                    Text("كن أنت أول شخص ينضم إلى الصفقة"),
                                  ],
                                )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                softWrap: false,
                                dealData.product.productDescription),
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
                                  const SizedBox(
                                    width: 5,
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
                                  const SizedBox(
                                    width: 5,
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
                                  const SizedBox(
                                    width: 5,
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
                                  const SizedBox(
                                    width: 5,
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
                BlocProvider(
                  create: (context) => DealDetailsCubit(),
                  child: Builder(builder: (context) {
                    final dealDCubit = context.read<DealDetailsCubit>();
                    return dealData.dealStatus == "active"
                        ? GetIt.I.get<UserDataLayer>().email != ""
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: context.getWidth(value: 0.3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            dealDCubit.increseEvent(
                                                maxOrderPerUser:
                                                    dealData.maxOrdersPerUser);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppColor.secondary),
                                            child: const Icon(Icons.add),
                                          ),
                                        ),
                                        BlocBuilder<DealDetailsCubit,
                                            DealDetailsState>(
                                          builder: (context, state) {
                                            return Text(
                                                dealDCubit.index.toString());
                                          },
                                        ),
                                        InkWell(
                                          onTap: () {
                                            dealDCubit.decreseEvent();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: AppColor.secondary),
                                            child: const Icon(Icons.remove),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  dealDCubit.enableJoin(dealId: dealData.dealId)
                                      ? SizedBox(
                                          width: context.getWidth(value: 0.6),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              int pQnt = await dealDCubit
                                                  .checkQuantity(
                                                      dealID: dealData.dealId);
                                              pQnt += dealDCubit.index;
                                              if (pQnt > dealData.quantity) {
                                                alert(
                                                    context: context,
                                                    msg:
                                                        "عذراً!يرجى تغيير الكمية",
                                                    isCompleted: false);
                                              } else if (await dealDCubit
                                                      .checkQuantity(
                                                          dealID: dealData
                                                              .dealId) ==
                                                  dealData.quantity) {
                                                alert(
                                                    context: context,
                                                    msg:
                                                        "عذراً!تم إكمال الصفقة",
                                                    isCompleted: false);
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PrePaymentScreen(
                                                            dealData: dealData,
                                                            items: dealDCubit
                                                                .index,
                                                          )),
                                                );
                                              }
                                            },
                                            child:
                                                const Text("إنضمام إلى الصفقة"),
                                          ),
                                        )
                                      : Text("انت منضم الى الصفقة")
                                ],
                              )
                            : SizedBox(
                                width: context.getWidth(value: 0.6),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                      );
                                    },
                                    child: const Text(
                                        "سجل الآن وانضم إلى الصفقة")),
                              )
                        : const SizedBox();
                  }),
                )
              ],
            ),
          )),
    );
  }
}
