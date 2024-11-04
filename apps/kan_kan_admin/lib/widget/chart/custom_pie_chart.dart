import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({super.key,  this.sections, required this.pieTouchData});
  final PieTouchData pieTouchData;
  final List<PieChartSectionData>? sections;
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
          pieTouchData: pieTouchData,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 12,
          centerSpaceRadius: 50,
          sections: sections),
    );
  }
}
