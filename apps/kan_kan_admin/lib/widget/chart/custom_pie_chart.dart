import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({super.key, this.touchCallback, this.sections});
  final void Function(FlTouchEvent, PieTouchResponse?)? touchCallback;
  final List<PieChartSectionData>? sections;
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: touchCallback,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 12,
          centerSpaceRadius: 50,
          sections: sections),
    );
  }
}
