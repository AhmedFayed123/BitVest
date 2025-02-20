import 'package:bitvest/core/components/widgets/circle_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/constant/clases.dart';
import '../../controller/chart_controller.dart';
import '../../controller/coin_details_controller.dart';

class CoinDetailsViewBody extends StatelessWidget {
  const CoinDetailsViewBody({super.key, required this.coinId});
  final String coinId;

  @override
  Widget build(BuildContext context) {
    final CoinDetailsController controller = Get.put(CoinDetailsController(coinId));
    final ChartController chartController = Get.put(ChartController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircleLoading());
      }

      final coin = controller.coinData.value?.original;
      if (coin == null) {
        return const Center(
          child: Text("No Data Available", style: TextStyle(color: Colors.white)),
        );
      }

      final List<ChartSampleData> chartData = (controller.selectedChartData?.isNotEmpty ?? false)
          ? controller.selectedChartData!
          .map<ChartSampleData>((e) {
        if (e.length >= 2) {
          double price = (e[1] as num).toDouble();
          return ChartSampleData(
            x: DateTime.fromMillisecondsSinceEpoch(e[0]),
            open: price,
            high: price,
            low: price,
            close: price,
          );
        } else {
          throw Exception("Invalid data format in selectedChartData: $e");
        }
      })
          .toList()
          : [];



      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  Text(
                    "${coin.name}/USDT",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.star_border, color: Colors.white, size: 24),
                      SizedBox(width: 10),
                      Icon(Icons.more_vert, color: Colors.white, size: 24),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${coin.price?.toString() ?? "0.00"}",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$${coin.price?.toString() ?? "0.00"} (+0.45%)",
                    style: const TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0.h),
                child: Obx(() {

                  return SfCartesianChart(
                    backgroundColor: Colors.grey.shade900,
                    plotAreaBorderWidth: 0,
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePinching: true,
                      enablePanning: true,
                      enableSelectionZooming: true,
                      enableDoubleTapZooming: true,
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true, color: Colors.black, textStyle: TextStyle(color: Colors.white)),

                    primaryXAxis: DateTimeAxis(
                      axisLine: AxisLine(color: chartController.showXAxis.value ? Colors.white : Colors.transparent),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 10),
                      majorGridLines: MajorGridLines(width: chartController.showGrid.value ? 0.5 : 0),
                      minorGridLines: MinorGridLines(width: chartController.showGrid.value ? 0.3 : 0),
                    ),

                    primaryYAxis: NumericAxis(
                      axisLine: AxisLine(color: chartController.showYAxis.value ? Colors.white : Colors.transparent),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 10),
                      majorGridLines: MajorGridLines(
                        color: chartController.showGrid.value ? Colors.grey.shade800.withOpacity(0.3) : Colors.transparent,
                        dashArray: [3, 3],
                      ),
                      minorGridLines: MinorGridLines(width: chartController.showGrid.value ? 0.3 : 0),
                    ),

                    series: <CartesianSeries>[
                      LineSeries<ChartSampleData, DateTime>(
                        dataSource: chartData,
                        xValueMapper: (ChartSampleData data, _) => data.x,
                        yValueMapper: (ChartSampleData data, _) => data.close,
                        color: chartController.lineColor.value,
                        width: chartController.lineWidth.value,
                        animationDuration: 1000,
                        enableTooltip: true,
                        markerSettings: MarkerSettings(
                          isVisible: chartController.showMarkers.value,
                          shape: DataMarkerType.circle,
                          color: chartController.markerColor.value,
                          borderWidth: 1.5,
                          borderColor: Colors.white,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Obx(() {
                final chartController = Get.find<ChartController>();

                return Column(
                  children: [
                    SwitchListTile(
                      title: Text("إظهار الشبكة", style: TextStyle(color: Colors.white)),
                      value: chartController.showGrid.value,
                      onChanged: (val) => chartController.showGrid.value = val,
                    ),
                    SwitchListTile(
                      title: Text("إظهار النقاط", style: TextStyle(color: Colors.white)),
                      value: chartController.showMarkers.value,
                      onChanged: (val) => chartController.showMarkers.value = val,
                    ),
                    SwitchListTile(
                      title: Text("إظهار محور X", style: TextStyle(color: Colors.white)),
                      value: chartController.showXAxis.value,
                      onChanged: (val) => chartController.showXAxis.value = val,
                    ),
                    SwitchListTile(
                      title: Text("إظهار محور Y", style: TextStyle(color: Colors.white)),
                      value: chartController.showYAxis.value,
                      onChanged: (val) => chartController.showYAxis.value = val,
                    ),
                    SizedBox(height: 10),
                    Text("عرض الخط", style: TextStyle(color: Colors.white)),
                    Slider(
                      value: chartController.lineWidth.value,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: chartController.lineWidth.value.toString(),
                      onChanged: (val) => chartController.lineWidth.value = val,
                    ),
                  ],
                );
              }),
            ),


            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['7D', '30D', '90D'].map((period) {
                  return Obx(() => TextButton(
                    onPressed: () {
                      controller.changePeriod(period);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor:
                      controller.selectedPeriod.value == period ? Colors.green : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        side: BorderSide(
                          color: controller.selectedPeriod.value == period
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                    ),
                    child: Text(period),
                  ));
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
