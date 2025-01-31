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
      series: <LineSeries<ChartData, String>>[
        LineSeries<ChartData, String>(
          dataSource: [
            ChartData('0', 1),
            ChartData('1', 90.5),
            ChartData('2', 200.4),
            ChartData('3', 3.4),
            ChartData('4', 400),
            ChartData('5', 100.2),
            ChartData('6', 2.8),
          ],
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: kPositiveTrendColor,
          width: 2,
        ),
      ],
    );
  }
}

