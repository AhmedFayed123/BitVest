import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/constant/clases.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {super.key,
      required this.name,
      required this.symbol,
      required this.price,
      required this.change,
      required this.percent,
      required this.chartData,
      required this.isNegative,
      required this.onTap,
      required this.imageUrl});

  final String name, symbol, price, change, percent, imageUrl;
  final List<CustomChartData> chartData;
  final bool isNegative;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0.w),
        child: Container(
          width: 150.w,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kCardBackgroundColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    imageUrl,
                    width: 30.w,
                    height: 30.h,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error, color: Colors.red),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      name,
                      style: AppStyles.textStyle16regular,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Text(
                symbol,
                style: AppStyles.textStyle14semiBold,
              ),
              SizedBox(
                width: 100.w,
                height: 65.h,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(isVisible: false),
                  primaryYAxis: NumericAxis(isVisible: false),
                  series: <LineSeries<CustomChartData, String>>[
                    LineSeries<CustomChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (CustomChartData data, _) => data.x,
                      yValueMapper: (CustomChartData data, _) =>
                          isNegative ? -data.y : data.y,
                      color: isNegative ? Colors.red : Colors.green,
                      width: 2.w,
                    ),
                  ],
                ),
              ),
              Text(
                "\$$price",
                style: AppStyles.textStyle16regular,
              ),
              Text("$change | $percent",
                  style: TextStyle(
                      color: isNegative ? Colors.red : Colors.green,
                      fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
