import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/cubits/deal_details_cubit/deal_details_cubit.dart';
import 'package:kan_kan_admin/local_data/status_list.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
import 'package:kan_kan_admin/widget/form/add_deal_form.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';
import 'package:ui/ui.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DealsDetailsScreen extends StatefulWidget {
  const DealsDetailsScreen({super.key, required this.dealId});
  final int dealId;
  @override
  State<DealsDetailsScreen> createState() => _DealsDetailsScreenState();
}

class _DealsDetailsScreenState extends State<DealsDetailsScreen>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TabController tabBar = TabController(length: 3, vsync: this);

    return BlocProvider(
      create: (context) =>
          DealDetailsCubit()..dealOrders(dealId: widget.dealId),
      child: Builder(builder: (context) {
        final detailCubit = context.read<DealDetailsCubit>();
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (DateConverter.saDateFormate(
                                            detailCubit.deal.endDate) !=
                                        DateConverter.saDateFormate(
                                            DateTime.now().toIso8601String()))
                                      if (detailCubit.deal.numberOfOrder == 0)
                                        IconButton(
                                          onPressed: () {
                                            detailCubit
                                                    .dealNameController.text =
                                                detailCubit.deal.dealTitle;
                                            detailCubit.productController.text =
                                                detailCubit
                                                    .deal.product.productId
                                                    .toString();
                                            detailCubit
                                                    .quantityController.text =
                                                detailCubit.deal.quantity
                                                    .toString();
                                            detailCubit
                                                    .maxNumberController.text =
                                                detailCubit
                                                    .deal.maxOrdersPerUser
                                                    .toString();
                                            detailCubit
                                                    .dealStatusController.text =
                                                detailCubit.deal.dealStatus;
                                            detailCubit
                                                    .dealTypeController.text =
                                                detailCubit.deal.categoryId
                                                    .toString();
                                            detailCubit.dealDurationController
                                                    .text =
                                                "${DateConverter.saDateFormate(detailCubit.deal.startDate)} الى ${DateConverter.saDateFormate(detailCubit.deal.endDate)}";
                                            detailCubit.priceController.text =
                                                detailCubit.deal.salePrice
                                                    .toString();
                                            detailCubit.costController.text =
                                                detailCubit.deal.costPrice
                                                    .toString();
                                            detailCubit.deliveryCostController
                                                    .text =
                                                detailCubit.deal.deliveryPrice
                                                    .toString();
                                            detailCubit
                                                    .estimatedTimeFromController
                                                    .text =
                                                detailCubit.deal
                                                    .estimateDeliveryDateFrom;
                                            detailCubit
                                                    .estimatedTimeToController
                                                    .text =
                                                detailCubit.deal
                                                    .estimateDeliveryTimeTo;
                                            detailCubit.dealDuration.add(
                                              DateTime.tryParse(
                                                DateConverter
                                                    .supabaseDateFormate(
                                                        detailCubit
                                                            .deal.startDate),
                                              ),
                                            );
                                            detailCubit.dealDuration.add(
                                              DateTime.tryParse(
                                                DateConverter
                                                    .supabaseDateFormate(
                                                        detailCubit
                                                            .deal.endDate),
                                              ),
                                            );
                                            detailCubit
                                                    .totalCostController.text =
                                                detailCubit.deal.totalPrice
                                                    .toString();
                                            customBottomSheet(
                                                context: context,
                                                child: AddDealForm(
                                                    totalController: detailCubit
                                                        .totalCostController,
                                                    dealCategory: detailCubit
                                                        .categoryLayer
                                                        .categories,
                                                    dealNameController: detailCubit
                                                        .dealNameController,
                                                    productController: detailCubit
                                                        .productController,
                                                    quantityController: detailCubit
                                                        .quantityController,
                                                    maxNumberController: detailCubit
                                                        .maxNumberController,
                                                    dealStatusController: detailCubit
                                                        .dealStatusController,
                                                    dealTypeController: detailCubit
                                                        .dealTypeController,
                                                    dealDurationController: detailCubit
                                                        .dealDurationController,
                                                    priceController: detailCubit
                                                        .priceController,
                                                    costController: detailCubit
                                                        .costController,
                                                    formKey: formKey,
                                                    add: () async {
                                                      await detailCubit
                                                          .updateDealEvent();
                                                    },
                                                    uploadImage: () {},
                                                    productsList: detailCubit
                                                        .productLayer.products
                                                        .where((product) =>
                                                            detailCubit.factoryLayer.getFactory(id: product.factory.factoryId).isBlackList ==
                                                            false)
                                                        .toList(),
                                                    dealDuration: () async {
                                                      final date =
                                                          await showCalendarDatePicker2Dialog(
                                                        context: context,
                                                        config: CalendarDatePicker2WithActionButtonsConfig(
                                                            firstDate:
                                                                DateTime.now(),
                                                            calendarType:
                                                                CalendarDatePicker2Type
                                                                    .range),
                                                        dialogSize: Size(
                                                          context.getWidth(
                                                              value: 0.5),
                                                          context.getHeight(
                                                              value: 0.5),
                                                        ),
                                                      );
                                                      try {
                                                        detailCubit
                                                                .dealDuration =
                                                            date!;
                                                        detailCubit
                                                                .dealDurationController
                                                                .text =
                                                            "${DateConverter.saDateFormate(detailCubit.dealDuration.first.toString())} الى ${DateConverter.saDateFormate(detailCubit.dealDuration.last.toString())}";
                                                      } catch (e) {
                                                        detailCubit
                                                            .dealDurationController
                                                            .clear();
                                                      }
                                                    },
                                                    deliveryCostController: detailCubit
                                                        .deliveryCostController,
                                                    estimatedTimeFromController:
                                                        detailCubit
                                                            .estimatedTimeFromController,
                                                    estimatedTimeToController:
                                                        detailCubit
                                                            .estimatedTimeToController));
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                    DateConverter.differenceInDays(
                                        endDate: detailCubit.deal.endDate)
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
                                        const Text("product:").tr(),
                                        Text(
                                          detailCubit.deal.product.productName,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Text(
                                        "SAR ${detailCubit.deal.costPrice.toString()}",
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
                                  child: BlocBuilder<DealDetailsCubit,
                                      DealDetailsState>(
                                    builder: (context, state) {
                                      return TabBar(
                                        labelColor: AppColor.white,
                                        dividerColor: AppColor.bg,
                                        indicatorPadding: const EdgeInsets.only(
                                            left: -40, right: -40),
                                        indicator: BoxDecoration(
                                          color: AppColor.secondary,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
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
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: context.getWidth(),
                                    height: 150,
                                    child: TabBarView(
                                        controller: tabBar,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.calendar_month,
                                                        color: AppColor.primary,
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      const Text(
                                                        "البداية : ",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .primary),
                                                      ),
                                                      Text(
                                                        DateConverter
                                                            .saDateFormate(
                                                                detailCubit.deal
                                                                    .startDate),
                                                        style: const TextStyle(
                                                            color: AppColor
                                                                .primary),
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
                                                        width: 20,
                                                      ),
                                                      const Text(
                                                        "النهاية : ",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .primary),
                                                      ),
                                                      Text(
                                                        DateConverter
                                                            .saDateFormate(
                                                                detailCubit.deal
                                                                    .endDate),
                                                        style: const TextStyle(
                                                            color: AppColor
                                                                .primary),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.local_shipping,
                                                        color: AppColor.primary,
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      const Text("التوصيل :"),
                                                      Text(
                                                          "${detailCubit.deal.estimateDeliveryDateFrom} - ${detailCubit.deal.estimateDeliveryTimeTo} "),
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
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          " (${detailCubit.deal.maxOrdersPerUser.toString()}) "),
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
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const Text("يتشارك عدد"),
                                                  Text(
                                                      "${detailCubit.deal.numberOfOrder} / ${detailCubit.deal.quantity}"),
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 5,
                                                        softWrap: false,
                                                        detailCubit.deal
                                                            .dealDescription),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .align_vertical_center,
                                                        color: AppColor.primary,
                                                      ),
                                                      const Text("الطول : "),
                                                      Text(
                                                          "${detailCubit.deal.product.length} سم")
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .align_horizontal_center,
                                                        color: AppColor.primary,
                                                      ),
                                                      const Text("العرض : "),
                                                      Text(
                                                          "${detailCubit.deal.product.width} اسم:")
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.height,
                                                        color: AppColor.primary,
                                                      ),
                                                      const Text("الإرتفاع : "),
                                                      Text(
                                                          "${detailCubit.deal.product.height} سم")
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
                                                          "${detailCubit.deal.product.weight} كج")
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.factory,
                                                        color: AppColor.primary,
                                                      ),
                                                      const Text("المصنع : "),
                                                      Text(detailCubit
                                                          .deal
                                                          .product
                                                          .factory
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
                                                      Text(detailCubit
                                                          .deal
                                                          .product
                                                          .factory
                                                          .region)
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.factory,
                                                        color: AppColor.primary,
                                                      ),
                                                      const Text(
                                                          "ممثل المصنع : "),
                                                      Text(detailCubit
                                                          .deal
                                                          .product
                                                          .factory
                                                          .factoryRepresentative)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.phone,
                                                        color: AppColor.primary,
                                                      ),
                                                      const Text(
                                                          "رقم التواصل :"),
                                                      Text(detailCubit
                                                          .deal
                                                          .product
                                                          .factory
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
                          height: context.getHeight(value: 0.48),
                          child: detailCubit.deal.dealUrl != ""
                              ? CachedNetworkImage(
                                  imageUrl: detailCubit.deal.dealUrl)
                              : Image.asset(
                                  "assets/images/logo/kan_kan_logo.png"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          detailCubit.trackingNumberController.text =
                              detailCubit.deal.trackingNumber;
                          customBottomSheet(
                            context: context,
                            height: 0.4,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  CustomTextField(
                                      controller:
                                          detailCubit.trackingNumberController,
                                      title: "رقم تتبع الصفقة"),
                                  SizedBox(
                                    width: context.getWidth(value: 0.25),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          detailCubit.addTrackingNumberEvent();
                                          Navigator.pop(context);
                                        },
                                        child: const Text("حفظ")),
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
                        if (detailCubit.currentOrders
                                .where(
                                    (order) => order.orderStatus == "completed")
                                .length !=
                            detailCubit.currentOrders.length)
                          SizedBox(
                            width: context.getWidth(value: 0.25),
                            height: context.getHeight(value: 0.25),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocBuilder<DealDetailsCubit,
                                  DealDetailsState>(
                                builder: (context, state) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (detailCubit.deal.dealStatus !=
                                          "completed")
                                        SizedBox(
                                          width: context.getWidth(value: 0.20),
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.secondary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () async {
                                                detailCubit.tmpStatus =
                                                    "completed";
                                                await detailCubit
                                                    .updateDealStatusEvent();
                                              },
                                              child:
                                                  const Text("إكمال الصفقة")),
                                        ),
                                      SizedBox(
                                        width: context.getWidth(value: 0.20),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              detailCubit.tmpOrderStatus =
                                                  'processing';
                                              updateStatus(
                                                  context: context,
                                                  onPressed: () async {
                                                    await detailCubit
                                                        .updateOrderStatus(
                                                      dealId: widget.dealId,
                                                    );
                                                  },
                                                  title: "تحديث حالة الطلب",
                                                  onChanged: (value) {
                                                    detailCubit.tmpOrderStatus =
                                                        value;
                                                  },
                                                  items: DropMenuList
                                                      .shipmentStatus
                                                      .map((element) =>
                                                          DropdownMenuItem(
                                                            value: element,
                                                            child: Text(element)
                                                                .tr(),
                                                          ))
                                                      .toList(),
                                                  value: "processing");
                                            },
                                            child: const Text(
                                                "تحديث حالة الطلبات")),
                                      ),
                                      if (detailCubit.deal.dealStatus !=
                                          "completed")
                                        SizedBox(
                                          width: context.getWidth(value: 0.20),
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                detailCubit.tmpStatus =
                                                    detailCubit.deal.dealStatus;
                                                await updateStatus(
                                                    onPressed: () async =>
                                                        await detailCubit
                                                            .updateDealStatusEvent(),
                                                    context: context,
                                                    title: "تحديث حلة الصفقة",
                                                    onChanged: (value) {
                                                      detailCubit.tmpStatus =
                                                          value.toString();
                                                    },
                                                    items: DropMenuList
                                                        .dealStatus
                                                        .map(
                                                          (element) =>
                                                              DropdownMenuItem(
                                                            value: element,
                                                            child: Text(element)
                                                                .tr(),
                                                          ),
                                                        )
                                                        .toList(),
                                                    value: detailCubit
                                                        .deal.dealStatus);
                                              },
                                              child: const Text(
                                                  "تحديث حالة الصفقة")),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: detailCubit.currentOrders
                                        .where((order) =>
                                            order.orderStatus == "completed")
                                        .length !=
                                    detailCubit.currentOrders.length
                                ? context.getWidth(value: 0.72)
                                : context.getWidth(value: 0.96),
                            child: TableSizedBox(
                              child: CustomTableTheme(
                                child: BlocBuilder<DealDetailsCubit,
                                    DealDetailsState>(
                                  builder: (context, state) {
                                    return PaginatedDataTable(
                                      rowsPerPage: 3,
                                      showEmptyRows: false,
                                      source: TableDataRow(
                                        length:
                                            detailCubit.currentOrders.length,
                                        customRow: List.generate(
                                            detailCubit.currentOrders.length,
                                            (index) {
                                          return DataRow(
                                            color: WidgetStateProperty.all(
                                                AppColor.white),
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
                                                        detailCubit
                                                            .currentOrders[
                                                                index]
                                                            .orderDate),
                                                  ),
                                                ),
                                              ),
                                              DataCell(CustomChips(
                                                status: detailCubit
                                                    .currentOrders[index]
                                                    .paymentStatus,
                                                statusColor: detailCubit
                                                    .currentOrders[index]
                                                    .paymentStatus,
                                                onTap: () async {
                                                  detailCubit.onePaymentStatus =
                                                      detailCubit
                                                          .currentOrders[index]
                                                          .paymentStatus;
                                                  await updateStatus(
                                                      value: detailCubit
                                                          .currentOrders[index]
                                                          .paymentStatus,
                                                      context: context,
                                                      title: "حالة",
                                                      onChanged: (value) {
                                                        detailCubit
                                                                .onePaymentStatus =
                                                            value;
                                                      },
                                                      onPressed: () async {
                                                        await detailCubit
                                                            .updateOnePaymentStatus(
                                                                index: index);
                                                      },
                                                      items: DropMenuList
                                                          .paymentStatus
                                                          .map<DropdownMenuItem>(
                                                              (String status) {
                                                        return DropdownMenuItem(
                                                          value: status,
                                                          child:
                                                              Text(status).tr(),
                                                        );
                                                      }).toList());
                                                },
                                              )),
                                              DataCell(CustomChips(
                                                status: detailCubit
                                                    .currentOrders[index]
                                                    .orderStatus,
                                                statusColor: detailCubit
                                                    .currentOrders[index]
                                                    .orderStatus,
                                                onTap: () async {
                                                  detailCubit.oneOrderStatus =
                                                      detailCubit
                                                          .currentOrders[index]
                                                          .orderStatus;
                                                  await updateStatus(
                                                      value: detailCubit
                                                          .currentOrders[index]
                                                          .orderStatus,
                                                      context: context,
                                                      title: "حالة",
                                                      onChanged: (value) {
                                                        detailCubit
                                                                .oneOrderStatus =
                                                            value.toString();
                                                      },
                                                      onPressed: () async {
                                                        await detailCubit
                                                            .updateOneOrderStatus(
                                                                index: index);
                                                      },
                                                      items: DropMenuList
                                                          .shipmentStatus
                                                          .map<DropdownMenuItem>(
                                                              (String status) {
                                                        return DropdownMenuItem(
                                                          value: status,
                                                          child:
                                                              Text(status).tr(),
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
                                          headingRowAlignment:
                                              MainAxisAlignment.center,
                                          label: Text("العميل"),
                                        ),
                                        DataColumn(
                                          headingRowAlignment:
                                              MainAxisAlignment.center,
                                          label: Text("تاريخ طلب"),
                                        ),
                                        DataColumn(
                                          headingRowAlignment:
                                              MainAxisAlignment.center,
                                          label: Text("حالة الدفع"),
                                        ),
                                        DataColumn(
                                          headingRowAlignment:
                                              MainAxisAlignment.center,
                                          label: Text("حالة"),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
