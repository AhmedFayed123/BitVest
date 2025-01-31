import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constant/clases.dart';
import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CustomCryptoListItem extends StatelessWidget {
  const CustomCryptoListItem({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.percent,
    required this.isNegative,
    required this.chartData,
  });

  final String name, symbol, price, change, percent;
  final bool isNegative;
  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Card(
        color: kCardBackgroundColor,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // أيقونة العملة
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.currency_bitcoin,
                    color: Colors.amber, size: 30),
              ),
              const SizedBox(width: 10),

              // اسم العملة والمعلومات الأساسية
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppStyles.textStyle16regular,
                    ),
                    Text(symbol,
                      style: AppStyles.textStyle18semiBold,
                    ),
                    const SizedBox(height: 5),
                    Text("\$$price",
                      style: AppStyles.textStyle14regular,
                    ),
                  ],
                ),
              ),

              // الرسم البياني الصغير
              SizedBox(
                width: 100,
                height: 40,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(isVisible: false),
                  primaryYAxis: NumericAxis(isVisible: false),
                  series: <LineSeries<ChartData, String>>[
                    LineSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      color: isNegative ? Colors.red : Colors.green,
                      width: 2,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // التغييرات في السعر
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$change | $percent",
                    style: TextStyle(
                      color: isNegative ? Colors.red : Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  IconButton(
                    icon: const Icon(Icons.star_border, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
