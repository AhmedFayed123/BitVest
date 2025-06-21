import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/constant/clases.dart';


class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.percent,
    required this.chartData,
    required this.isNegative,
    required this.onTap,
    required this.imageUrl,
  });

  final String name, symbol, price, change, percent, imageUrl;
  final List<CustomChartData> chartData;
  final bool isNegative;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140.w,
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo + name
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 28.w,
                    height: 28.h,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(Icons.error, color: Colors.red, size: 20.sp),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 4.h),

            // Symbol
            Text(
              symbol,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade400,
              ),
            ),

            // Chart
            SizedBox(
              height: 50.h,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                margin: EdgeInsets.zero,
                primaryXAxis: CategoryAxis(isVisible: false),
                primaryYAxis: NumericAxis(isVisible: false),
                series: <LineSeries<CustomChartData, String>>[
                  LineSeries<CustomChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (CustomChartData data, _) => data.x,
                    yValueMapper: (CustomChartData data, _) =>
                    isNegative ? -data.y : data.y,
                    color: isNegative ? Colors.redAccent : Colors.greenAccent,
                    width: 2.2.w,
                  ),
                ],
              ),
            ),

            // Price
            Text(
              price,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Change info
            Text(
              "$change | $percent",
              style: TextStyle(
                fontSize: 11.sp,
                color: isNegative ? Colors.redAccent : Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
