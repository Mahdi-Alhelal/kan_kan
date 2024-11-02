import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/cubits/home_cubit/home_cubit.dart';
import 'package:kan_kan_admin/helper/calulator.dart';
import 'package:kan_kan_admin/helper/indecator.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:kan_kan_admin/widget/card/app_statistics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/custom_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final homeCubit = context.read<HomeCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppStatistics(
                      icon: Icons.handshake_outlined,
                      number: homeCubit.dealLayer.deals.length,
                      type: "عدد الصفقات",
                    ),
                    AppStatistics(
                      icon: Icons.factory,
                      number: homeCubit.factoryLayer.factories.length,
                      type: "عدد المصانع",
                    ),
                    AppStatistics(
                      icon: Icons.people_outline,
                      number: homeCubit.userLayer.usersList.length,
                      type: "عدد المسخدمين",
                    ),
                    AppStatistics(
                      icon: Icons.production_quantity_limits,
                      number: homeCubit.orderLayer.orders.length,
                      type: "عدد الطلبات",
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Row(
                  children: [
                    SizedBox(
                      width: 350,
                      height: 250,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                              width: 200,
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(
                                    touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        homeCubit.touchedIndex = -1;
                                        return;
                                      }
                                      homeCubit.touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                      homeCubit.update();
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 12,
                                  centerSpaceRadius: 50,
                                  sections: showingSections(
                                    touchedIndex: homeCubit.touchedIndex,
                                    pendingNum: homeCubit.pendingNum,
                                    processingNum: homeCubit.processingNum,
                                    inChinaNum: homeCubit.inChinaNum,
                                    inTransitNum: homeCubit.inTransitNum,
                                    inSaudiNum: homeCubit.inSaudiNum,
                                    withShipmentCompanyNum:
                                        homeCubit.withShipmentCompanyNum,
                                    completedNum: homeCubit.completedNum,
                                    canceledNum: homeCubit.canceledNum,
                                    total: homeCubit.total,
                                  ),
                                ),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Indicator(
                                  color: Colors.amberAccent,
                                  text: 'First',
                                  isSquare: true,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Indicator(
                                  color: Colors.brown,
                                  text: 'Second',
                                  isSquare: true,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Indicator(
                                  color: Colors.yellow,
                                  text: 'Third',
                                  isSquare: true,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Indicator(
                                  color: Colors.indigoAccent,
                                  text: 'Fourth',
                                  isSquare: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (homeCubit.orderLayer.orders.isNotEmpty &&
                    homeCubit.dealLayer.deals.isNotEmpty) {
                  homeCubit.orderLayer.orders
                      .sort((a, b) => b.orderId.compareTo(a.orderId));
                  return TableSizedBox(
                    child: CustomTableTheme(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return PaginatedDataTable(
                            rowsPerPage: 3,
                            showEmptyRows: false,
                            source: TableDataRow(
                              length: homeCubit.orderLayer.orders
                                  .getRange(0, 3)
                                  .length,
                              customRow: List.generate(
                                  homeCubit.orderLayer.orders
                                      .getRange(0, 5)
                                      .length, (index) {
                                UserModel orderUser = homeCubit.userLayer
                                    .getOrderUser(
                                        id: homeCubit
                                            .orderLayer.orders[index].userId);

                                DealModel myDeal = homeCubit.dealLayer.deals
                                    .firstWhere((element) =>
                                        element.dealId ==
                                        homeCubit
                                            .orderLayer.orders[index].dealId);

                                homeCubit.productLayer.getProductOrder(
                                    id: myDeal.product.productId);
                                String languageCode =
                                    Localizations.localeOf(context)
                                        .languageCode;

                                OrderStatus orderStatus =
                                    EnumOrderHelper.stringToOrderStatus(
                                        homeCubit.orderLayer.orders[index]
                                            .orderStatus);
                                String localizedOrderStatus =
                                    LocalizedEnums.getOrderStatusName(
                                        orderStatus, languageCode);

                                PaymentEnums paymentStatus =
                                    EnumPaymentHelper.stringToOrderStatus(
                                        homeCubit.orderLayer.orders[index]
                                            .orderStatus);
                                String localizedPaymentStatus =
                                    LocalizedPaymentEnums.getPaymentStatusName(
                                        paymentStatus, languageCode);

                                return DataRow(
                                  color:
                                      WidgetStateProperty.all(AppColor.white),
                                  cells: [
                                    DataCell(
                                      Row(
                                        children: [
                                          Text(
                                              "${orderUser.fullName}\n O${homeCubit.orderLayer.orders[index].orderId}")
                                        ],
                                      ),
                                    ),
                                    DataCell(Text(
                                        "${homeCubit.orderLayer.orders[index].amount}")),
                                    DataCell(Text(myDeal.dealTitle)),
                                    DataCell(Text(DateConverter.usDateFormate(
                                        homeCubit.orderLayer.orders[index]
                                            .orderDate))),
                                    DataCell(CustomChips(
                                      statusColor: true,
                                      status: localizedPaymentStatus,
                                    )),
                                    DataCell(CustomChips(
                                      statusColor:
                                          EnumOrderHelper.stringToOrderStatus(
                                              homeCubit.orderLayer.orders[index]
                                                  .orderStatus),
                                      status: localizedOrderStatus,
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
                                label: Text("السعر"),
                              ),
                              DataColumn(
                                headingRowAlignment: MainAxisAlignment.center,
                                label: Text("الصفقة"),
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
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ]),
        );
      }),
    );
  }
}

List<PieChartSectionData> showingSections({
  required int touchedIndex,
  required num pendingNum,
  required num processingNum,
  required num inChinaNum,
  required num inTransitNum,
  required num inSaudiNum,
  required num withShipmentCompanyNum,
  required num completedNum,
  required num canceledNum,
  required num total,
}) {
  return List.generate(8, (i) {
    final isTouched = (i == touchedIndex);
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 70.0 : 50.0;
    const shadows = [Shadow(color: Colors.white, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.amberAccent,
          value: calPer(
            total: total,
            value: pendingNum,
          ),
          title: pendingNum != 0
              ? '${calPer(value: pendingNum, total: total).round()}%'
              : '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.brown,
          value: calPer(
            total: total,
            value: processingNum,
          ),
          title: processingNum != 0
              ? '${calPer(value: processingNum, total: total).round()}%'
              : '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 2:
        return PieChartSectionData(
          showTitle: true,
          color: Colors.yellow,
          value: calPer(
            total: total,
            value: inChinaNum,
          ),
          title: inChinaNum != 0
              ? '${calPer(value: inChinaNum, total: total).round()}%'
              : '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: Colors.lime,
          value: calPer(
            total: total,
            value: inTransitNum,
          ),
          title: inTransitNum != 0
              ? '${calPer(value: inTransitNum, total: total).round()}%'
              : '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 4:
        return PieChartSectionData(
          color: Colors.green,
          value: calPer(
            total: total,
            value: inSaudiNum,
          ),
          title: inSaudiNum != 0
              ? '${calPer(value: inSaudiNum, total: total).round()}%'
              : '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 5:
        return PieChartSectionData(
          color: Colors.green,
          value: calPer(
            total: total,
            value: withShipmentCompanyNum,
          ),
          title: withShipmentCompanyNum != 0
              ? '${calPer(value: withShipmentCompanyNum, total: total).round()}%'
              : '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 6:
        return PieChartSectionData(
          color: Colors.deepPurple,
          value: calPer(total: total, value: completedNum),
          title: completedNum != 0
              ? '${calPer(value: completedNum, total: total).round()}%'
              : '',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 7:
        return PieChartSectionData(
          color: const Color.fromARGB(255, 120, 4, 89),
          value: calPer(
            total: total,
            value: calPer(value: canceledNum, total: total),
          ),
          title: canceledNum != 0
              ? '${calPer(value: canceledNum, total: total).round()}%'
              : "",
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}
