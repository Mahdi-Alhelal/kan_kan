import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key, required this.barGroups});
  final List<BarChartGroupData>? barGroups;
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String barTitle = '';
                    switch (value.toInt()) {
                      case 0:
                        barTitle = 'private';
                        break;
                      case 1:
                        barTitle = 'closed';
                        break;
                      case 2:
                        barTitle = 'active';
                        break;
                      case 3:
                        barTitle = 'completed';
                        break;
                      case 4:
                        barTitle = 'pending';
                        break;
                      default:
                        barTitle = '';
                        break;
                    }
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 5,
                      child: Text(
                        barTitle,
                      ).tr(),
                    );
                  }),
            ),
          ),
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          minY: 0),
    );
  }
}
