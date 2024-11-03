
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kan_kan_admin/helper/calulator.dart';

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
