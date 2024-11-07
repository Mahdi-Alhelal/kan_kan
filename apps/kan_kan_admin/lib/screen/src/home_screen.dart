import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helper/helper.dart';
import 'package:kan_kan_admin/cubits/home_cubit/home_cubit.dart';
import 'package:kan_kan_admin/helper/indecator.dart';
import 'package:kan_kan_admin/helper/pie_chart_section.dart';
import 'package:kan_kan_admin/helper/table_data_row.dart';
import 'package:kan_kan_admin/model/deal_model.dart';
import 'package:kan_kan_admin/model/user_model.dart';
import 'package:kan_kan_admin/widget/card/app_statistics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kan_kan_admin/widget/chart/custom_bar_chart.dart';
import 'package:kan_kan_admin/widget/chart/custom_pie_chart.dart';
import 'package:kan_kan_admin/widget/chip/custom_chips.dart';
import 'package:kan_kan_admin/widget/table/custom_table_theme.dart';
import 'package:kan_kan_admin/widget/table/table_sized_box.dart';
import 'package:ui/component/helper/custom_colors.dart';
import 'package:ui/component/helper/screen.dart';

import 'package:ui/ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final homeCubit = context.read<HomeCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppStatistics(
                        icon: Icons.handshake_outlined,
                        number: homeCubit.dealLayer.deals.length,
                        type: "number of deals",
                      ),
                      AppStatistics(
                        icon: Icons.factory,
                        number: homeCubit.factoryLayer.factories.length,
                        type: "number of factories",
                      ),
                      AppStatistics(
                        icon: Icons.people_outline,
                        number: homeCubit.userLayer.usersList.length,
                        type: "number of users",
                      ),
                      AppStatistics(
                        icon: Icons.production_quantity_limits,
                        number: homeCubit.orderLayer.orders.length,
                        type: "number of orders",
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 25),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 350,
                        height: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Indicator(
                                  color: Colors.amberAccent,
                                  text: 'pending',
                                  isSquare: false,
                                ),
                                Indicator(
                                  color: Colors.brown,
                                  text: 'processing',
                                  isSquare: false,
                                ),
                                Indicator(
                                  color: Colors.black,
                                  text: 'inChina',
                                  isSquare: false,
                                ),
                                Indicator(
                                  color: Colors.indigoAccent,
                                  text: 'inTransit',
                                  isSquare: false,
                                ),
                                Indicator(
                                  color: Colors.green,
                                  text: 'inSaudi',
                                  isSquare: false,
                                ),
                                Indicator(
                                  color: Colors.grey,
                                  text: 'withShipmentCompany',
                                  isSquare: false,
                                ),
                                Indicator(
                                  color: Colors.deepPurple,
                                  text: 'completed',
                                  isSquare: false,
                                ),
                                Indicator(
                                  color: Color.fromARGB(255, 120, 4, 89),
                                  text: 'canceled',
                                  isSquare: false,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 200,
                              child: CustomPieChart(
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
                                  total: homeCubit.total != 0
                                      ? homeCubit.total
                                      : 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: context.getWidth(value: .4),
                        child: CustomBarChart(
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(
                                    toY: homeCubit.dealLayer.deals
                                        .where((element) =>
                                            element.dealStatus == "private")
                                        .length
                                        .toDouble()),
                              ],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  toY: homeCubit.dealLayer.deals
                                      .where((element) =>
                                          element.dealStatus == "closed ")
                                      .length
                                      .toDouble(),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  toY: homeCubit.dealLayer.deals
                                      .where((element) =>
                                          element.dealStatus == "active")
                                      .length
                                      .toDouble(),
                                )
                              ],
                            ),
                            BarChartGroupData(
                              x: 3,
                              barRods: [
                                BarChartRodData(
                                  toY: homeCubit.dealLayer.deals
                                      .where((element) =>
                                          element.dealStatus == "completed")
                                      .length
                                      .toDouble(),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 4,
                              barRods: [
                                BarChartRodData(
                                  toY: homeCubit.dealLayer.deals
                                      .where((element) =>
                                          element.dealStatus == "pending")
                                      .length
                                      .toDouble(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 25,
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
                                        statusColor: homeCubit.orderLayer
                                            .orders[index].paymentStatus,
                                        status: homeCubit.orderLayer
                                            .orders[index].paymentStatus,
                                      )),
                                      DataCell(CustomChips(
                                        statusColor: homeCubit.orderLayer
                                            .orders[index].orderStatus,
                                        status: homeCubit.orderLayer
                                            .orders[index].orderStatus,
                                      )),
                                    ],
                                  );
                                }),
                              ),
                              columns:  [
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: const Text("customer").tr(),
                                ),
                                DataColumn(
                                  label: const Text("price").tr(),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: const Text("deal").tr(),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: const Text("order date").tr(),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: const Text("payment status").tr(),
                                ),
                                DataColumn(
                                  headingRowAlignment: MainAxisAlignment.center,
                                  label: const Text("order status").tr(),
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
          ),
        );
      }),
    );
  }
}
