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
          child: SingleChildScrollView(
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
              const SizedBox(height: 10),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 350,
                        height: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                      const SizedBox(
                          height: 200,
                          width: 200,
                          child: CustomBarChart(
                            barGroups: [],
                          )),
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
          ),
        );
      }),
    );
  }
}
