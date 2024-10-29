import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/cubits/deal_details_cubit/deal_details_cubit.dart';
import 'package:kan_kan_admin/dummy_data/order_dummy.dart';
import 'package:kan_kan_admin/dummy_data/status_list.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
import 'package:kan_kan_admin/widget/form/add_deal_form.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';
import 'package:ui/ui.dart';

class DealsDetailsScreen extends StatefulWidget {
  const DealsDetailsScreen({super.key, required this.deal});
  final DealModel deal;
  @override
  State<DealsDetailsScreen> createState() => _DealsDetailsScreenState();
}

class _DealsDetailsScreenState extends State<DealsDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabBar = TabController(length: 3, vsync: this);

    return BlocProvider(
      create: (context) =>
          DealDetailsCubit()..dealOrders(dealId: widget.deal.dealId),
      child: Builder(builder: (context) {
        final detailCubit = context.read<DealDetailsCubit>();
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
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
                                if (DateConverter.saDateFormate(
                                        widget.deal.endDate) !=
                                    DateConverter.saDateFormate(
                                        DateTime.now().toIso8601String()))
                                  if (widget.deal.numberOfOrder ==
                                      widget.deal.quantity)
                                    IconButton(
                                      onPressed: () {
                                        customBottomSheet(
                                            context: context, child: Text(""));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    children: [
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.deal.product.productName,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(widget.deal.costPrice.toString(),
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
                                  controller: tabBar,
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
                              child: SizedBox(
                                width: context.getWidth(),
                                height: 150,
                                child:
                                    TabBarView(controller: tabBar, children: [
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
                                                Icons.calendar_month,
                                                color: AppColor.primary,
                                              ),
                                              const Text(
                                                "البداية : ",
                                                style: TextStyle(
                                                    color: AppColor.primary),
                                              ),
                                              Text(
                                                DateConverter.saDateFormate(
                                                    widget.deal.startDate),
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
                                              const Text(
                                                "النهاية : ",
                                                style: TextStyle(
                                                    color: AppColor.primary),
                                              ),
                                              Text(
                                                DateConverter.saDateFormate(
                                                    widget.deal.endDate),
                                                style: const TextStyle(
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
                                                  "${widget.deal.estimateDeliveryDateFrom} - ${widget.deal.estimateDeliveryTimeTo} "),
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
                                              Text(widget.deal.maxOrdersPerUser
                                                  .toString()),
                                              const Text("عدد لكل شخص")
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
                                              "${widget.deal.numberOfOrder} / ${widget.deal.quantity}"),
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
                                                widget.deal.dealDescription),
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
                                                  "${widget.deal.product.length} سم")
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
                                                  "${widget.deal.product.width} اسم:")
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
                                                  "${widget.deal.product.height} سم")
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
                                                  "${widget.deal.product.weight} كج")
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
                                              Text(widget.deal.product.factory
                                                  .factoryName)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.place,
                                                color: AppColor.primary,
                                              ),
                                              const Text("المنطقة :"),
                                              Text(widget
                                                  .deal.product.factory.region)
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
                                              Text(widget.deal.product.factory
                                                  .factoryRepresentative)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone,
                                                color: AppColor.primary,
                                              ),
                                              const Text("رقم التواصل :"),
                                              Text(widget.deal.product.factory
                                                  .contactPhone)
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
                ElevatedButton(
                    onPressed: () {
                      customBottomSheet(
                        context: context,
                        height: 0.4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const CustomTextField(title: "رقم تتبع الصفقة"),
                              SizedBox(
                                width: context.getWidth(value: 0.25),
                                child: ElevatedButton(
                                    onPressed: () {}, child: const Text("حفظ")),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Text("رقم تتبع الصفقة")),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: AppColor.black.withOpacity(20 / 100),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: context.getWidth(value: 0.25),
                      height: context.getHeight(value: 0.25),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: context.getWidth(value: 0.20),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("إكمال الصفقة")),
                            ),
                            SizedBox(
                              width: context.getWidth(value: 0.20),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("تحديث حالة الطلبات")),
                            ),
                            SizedBox(
                              width: context.getWidth(value: 0.20),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("تحديث حالة الصفقة")),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: context.getWidth(value: 0.72),
                        child: TableSizedBox(
                          child: CustomTableTheme(
                            child: PaginatedDataTable(
                              rowsPerPage: 3,
                              showEmptyRows: false,
                              source: TableDataRow(
                                length: detailCubit.currentOrders.length,
                                customRow: List.generate(
                                    detailCubit.currentOrders.length, (index) {
                                  return DataRow(
                                    color:
                                        WidgetStateProperty.all(AppColor.white),
                                    cells: [
                                      DataCell(
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "${detailCubit.userLayer.getOrderUser(id: detailCubit.currentOrders[index].userId).fullName}\n${detailCubit.currentOrders[index].orderId}")
                                          ],
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            DateConverter.saDateFormate(
                                                detailCubit.currentOrders[index]
                                                    .orderDate),
                                          ),
                                        ),
                                      ),
                                      //Todo! to add payment status
                                      DataCell(CustomChips(
                                        status: "need to fix",
                                        onTap: () async {
                                          await updateStatus(
                                              value: DropMenuList
                                                  .paymentStatus.first,
                                              context: context,
                                              title: "حالة",
                                              onChanged: (value) {},
                                              items: DropMenuList.paymentStatus
                                                  .map<
                                                          DropdownMenuEntry<
                                                              String>>(
                                                      (String status) {
                                                return DropdownMenuEntry(
                                                  value: status,
                                                  label: status,
                                                );
                                              }).toList());
                                        },
                                      )),
                                      DataCell(CustomChips(
                                        status: detailCubit
                                            .currentOrders[index].orderStatus,
                                        onTap: () async {
                                          await updateStatus(
                                              value: DropMenuList
                                                  .shipmentStatus.first,
                                              context: context,
                                              title: "حالة",
                                              onChanged: (value) {},
                                              items: DropMenuList.shipmentStatus
                                                  .map<
                                                          DropdownMenuEntry<
                                                              String>>(
                                                      (String status) {
                                                return DropdownMenuEntry(
                                                  value: status,
                                                  label: status,
                                                );
                                              }).toList());
                                        },
                                      )),
                                    ],
                                  );
                                }),
                              ),
                              columns: const [
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text("العميل"),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text("تاريخ طلب"),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text("حالة الدفع"),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: Text("حالة"),
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
