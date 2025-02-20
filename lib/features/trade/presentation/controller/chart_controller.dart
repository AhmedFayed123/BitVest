import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChartController extends GetxController {
  RxBool showGrid = true.obs;
  RxBool showMarkers = false.obs;
  RxBool showXAxis = true.obs;
  RxBool showYAxis = true.obs;

  Rx<Color> lineColor = Colors.green.shade400.obs;
  RxDouble lineWidth = 2.5.obs;
  Rx<Color> markerColor = Colors.red.obs;
}
