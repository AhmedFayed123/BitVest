import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/constant/clases.dart';
import '../../../../../core/constant/colors.dart';

class CardLineChart extends StatelessWidget {
  const CardLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      series: <LineSeries<CustomChartData, String>>[
        LineSeries<CustomChartData, String>(
          dataSource: [
            CustomChartData('0', 1),
            CustomChartData('1', 90.5),
            CustomChartData('2', 200.4),
            CustomChartData('3', 3.4),
            CustomChartData('4', 400),
            CustomChartData('5', 100.2),
            CustomChartData('6', 2.8),
          ],
          xValueMapper: (CustomChartData data, _) => data.x,
          yValueMapper: (CustomChartData data, _) => data.y,
          color: kPositiveTrendColor,
          width: 2,
        ),
      ],
    );
  }
}

