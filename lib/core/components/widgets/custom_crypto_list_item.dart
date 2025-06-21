import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../features/trade/presentation/controller/trade_controller.dart';
import '../../constant/clases.dart';
import '../../constant/colors.dart';
import '../../constant/styles.dart';
import 'circle_loading.dart';

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
    required this.img,
    required this.onTap,
    required this.id,
  });

  final String name, symbol, price, change, percent, img, id;
  final bool isNegative;
  final List<CustomChartData> chartData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final TradeController tradeController = Get.put(TradeController());

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: kCardBackgroundColor,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              // ✅ Coin Image
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: img,
                  width: 34.w,
                  height: 34.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircleLoading(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: Colors.red, size: 24.sp),
                ),
              ),
              SizedBox(width: 10.w),

              // ✅ Coin Info
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppStyles.textStyle14semiBold,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      symbol,
                      style: AppStyles.textStyle12regular.copyWith(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      "\$$price",
                      style: AppStyles.textStyle14regular.copyWith(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // ✅ Mini Chart
              SizedBox(
                width: 70.w,
                height: 40.h,
                child: SfCartesianChart(
                  margin: EdgeInsets.zero,
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(isVisible: false),
                  primaryYAxis: NumericAxis(isVisible: false),
                  series: <LineSeries<CustomChartData, String>>[
                    LineSeries<CustomChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (data, _) => data.x,
                      yValueMapper: (data, _) => isNegative ? -data.y : data.y,
                      color: isNegative ? Colors.red : Colors.green,
                      width: 2.w,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // ✅ Change & Star
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "$change | $percent",
                    style: TextStyle(
                      color: isNegative ? Colors.red : Colors.green,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: () => tradeController.toggleFavourite(id),
                    child: Obx(() {
                      return Icon(
                        tradeController.isFavourite(id)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 22.sp,
                      );
                    }),
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


// class CustomCryptoListItem extends StatelessWidget {
//   const CustomCryptoListItem({
//     super.key,
//     required this.name,
//     required this.symbol,
//     required this.price,
//     required this.change,
//     required this.percent,
//     required this.isNegative,
//     required this.chartData,
//   });
//
//   final String name, symbol, price, change, percent;
//   final bool isNegative;
//   final List<ChartData> chartData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.0.w),
//       child: Card(
//         color: kCardBackgroundColor,
//         elevation: 3,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//         child: Padding(
//           padding: EdgeInsets.all(12.sp),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // أيقونة العملة
//               Container(
//                 padding: EdgeInsets.all(6.sp),
//                 decoration: BoxDecoration(
//                   color: Colors.amber.shade200,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(Icons.currency_bitcoin,
//                     color: Colors.amber, size: 30.sp),
//               ),
//               SizedBox(width: 10.w),
//
//               // اسم العملة والمعلومات الأساسية
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: AppStyles.textStyle12regular
//                     ),
//                     Text(
//                       symbol,
//                       style: AppStyles.textStyle16bold,
//                     ),
//                     SizedBox(height: 5.h),
//                     Text(
//                       "\$$price",
//                       style: AppStyles.textStyle14regular,
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(
//                 width: 100.w,
//                 height: 40.h,
//                 child: SfCartesianChart(
//                   plotAreaBorderWidth: 0,
//                   primaryXAxis: CategoryAxis(isVisible: false),
//                   primaryYAxis: NumericAxis(isVisible: false),
//                   series: <LineSeries<ChartData, String>>[
//                     LineSeries<ChartData, String>(
//                       dataSource: chartData,
//                       xValueMapper: (ChartData data, _) => data.x,
//                       yValueMapper: (ChartData data, _) => data.y,
//                       color: isNegative ? Colors.red : Colors.green,
//                       width: 2.w,
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(width: 10.w),
//
//               // التغييرات في السعر
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "$change | $percent",
//                     style: TextStyle(
//                       color: isNegative ? Colors.red : Colors.green,
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5.h),
//                   IconButton(
//                     icon: const Icon(Icons.star_border, color: kGreyColor),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
