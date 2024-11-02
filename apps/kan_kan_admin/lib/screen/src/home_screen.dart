import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kan_kan_admin/cubits/home_cubit/home_cubit.dart';
import 'package:kan_kan_admin/helper/calulator.dart';
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
                return SizedBox(
                  width: 350,
                  height: 300,
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
                                      pieTouchResponse.touchedSection == null) {
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
    final isTouched = (i == touchedIndex);
    print("$i ---$isTouched ");
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
          title: '${(pendingNum / total) * 100}%',
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
          title: '${(processingNum / total) * 100}%',
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
          title: '${(inChinaNum / total) * 100}%',
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
          title: '${(inTransitNum / total) * 100}%',
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
          title: '${(inSaudiNum / total) * 100}%',
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
          title: '${(withShipmentCompanyNum / total) * 100}%',
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
          title: '${(completedNum / total) * 100}%',
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
          title: '${(canceledNum / total) * 100}%',
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
