import 'package:flutter/material.dart';
import 'package:kan_kan_admin/dummy_data/order_dummy.dart';
import 'package:kan_kan_admin/dummy_data/status_list.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/dialog/update_status.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/screen.dart';
import 'package:ui/component/widget/custom_text_field.dart';
import 'package:ui/ui.dart';

class DealsDetailsScreen extends StatefulWidget {
  const DealsDetailsScreen({super.key});

  @override
  State<DealsDetailsScreen> createState() => _DealsDetailsScreenState();
}

class _DealsDetailsScreenState extends State<DealsDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabBar = TabController(length: 3, vsync: this);

    return SafeArea(
      child: Scaffold(
        body: Column(
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
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColor.primary,
                                )),
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
                          child: SizedBox(
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
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  customBottomSheet(
                      context: context,
                      height: 0.4,
                      child: Column(
                        children: [
                          CustomTextField(title: "رقم تتبع الصفقة"),
                          SizedBox(
                            width: context.getWidth(value: 0.25),
                            child: ElevatedButton(
                                onPressed: () {}, child: Text("حفظ")),
                          )
                        ],
                      ));
                },
                child: Text("رقم تتبع الصفقة")),
            SizedBox(
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
                              child: Text("إكمال الصفقة")),
                        ),
                        SizedBox(
                          width: context.getWidth(value: 0.20),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text("تحديث حالة الطلبات")),
                        ),
                        SizedBox(
                          width: context.getWidth(value: 0.20),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text("تحديث حالة الصفقة")),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    width: context.getWidth(value: 0.72),
                    child: TableSizedBox(
                      child: CustomTableTheme(
                        child: PaginatedDataTable(
                          rowsPerPage: 3,
                          showEmptyRows: false,
                          source: TableDataRow(
                            length: orderList.length,
                            customRow: List.generate(
                              orderList.length,
                              (index) => DataRow(
                                color: WidgetStateProperty.all(AppColor.white),
                                cells: [
                                  DataCell(
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${orderList[index].customerName}\n${orderList[index].orderNumber}")
                                      ],
                                    ),
                                  ),
                                  DataCell(Center(
                                      child: Text(orderList[index].orderDate))),
                                  DataCell(CustomChips(
                                    status: orderList[index].status,
                                    onTap: () async {
                                      await updateStatus(
                                          value:
                                              DropMenuList.paymentStatus.first,
                                          context: context,
                                          title: "حالة",
                                          onChanged: (value) {},
                                          items: DropMenuList.paymentStatus
                                              .map<DropdownMenuItem<String>>(
                                                  (String status) {
                                            return DropdownMenuItem(
                                              value: status,
                                              child: Text(status),
                                            );
                                          }).toList());
                                    },
                                  )),
                                  DataCell(CustomChips(
                                    status: orderList[index].shipmentStatus,
                                    onTap: () async {
                                      await updateStatus(
                                          value:
                                              DropMenuList.shipmentStatus.first,
                                          context: context,
                                          title: "حالة",
                                          onChanged: (value) {},
                                          items: DropMenuList.shipmentStatus
                                              .map<DropdownMenuItem<String>>(
                                                  (String status) {
                                            return DropdownMenuItem(
                                              value: status,
                                              child: Text(status),
                                            );
                                          }).toList());
                                    },
                                  )),
                                ],
                              ),
                            ),
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
  }
}
