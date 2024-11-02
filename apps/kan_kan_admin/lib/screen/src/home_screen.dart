import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan_admin/cubits/home_cubit/home_cubit.dart';
import 'package:kan_kan_admin/helper/indecator.dart';
import 'package:kan_kan_admin/widget/card/app_statistics.dart';
import 'package:fl_chart/fl_chart.dart';

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
                return Card(
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          height: 18,
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    homeCubit.touchedIndex = -1;
                                    return;
                                  }
                                  homeCubit.touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                  homeCubit.update();
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 9,
                                centerSpaceRadius: 90,
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
                );
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
    final isTouched = i == touchedIndex;
    final fontSize = isTouched ? 25.0 : 16.0;
    final radius = isTouched ? 90.0 : 50.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.amberAccent,
          value: (pendingNum / total) * 100,
          title: '${(pendingNum / total) * 100}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.brown,
          value: (processingNum / total) * 100,
          title: '${(processingNum / total) * 100}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: Colors.yellow,
          value: (inChinaNum / total) * 100,
          title: '${(inChinaNum / total) * 100}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: Colors.lime,
          value: (inTransitNum / total) * 100,
          title: '${(inTransitNum / total) * 100}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      case 4:
        return PieChartSectionData(
          color: Colors.green,
          value: (inSaudiNum / total) * 100,
          title: '${(inSaudiNum / total) * 100}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      case 5:
        return PieChartSectionData(
          color: Colors.black,
          value: (withShipmentCompanyNum / total) * 100,
          title: '${(withShipmentCompanyNum / total) * 100}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      case 6:
        return PieChartSectionData(
          color: Colors.deepPurple,
          value: (completedNum / total) * 100,
          title: '${(completedNum / total) * 100}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      case 7:
        return PieChartSectionData(
          color: Colors.black,
          value: (canceledNum / total),
          title: '${(canceledNum / total) * 100}%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}
