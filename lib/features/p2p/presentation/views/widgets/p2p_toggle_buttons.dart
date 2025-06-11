import 'package:bitvest/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/p2p_controller.dart';

class P2pToggleButtons extends StatelessWidget {
  const P2pToggleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<P2pController>();

    return Obx(() => Center(
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(12),
        fillColor: controller.isBuying.value?kPositiveTrendColor:kNegativeTrendColor,
        selectedColor: Colors.black,
        color: Colors.white,
        isSelected: [
          controller.isBuying.value,
          !controller.isBuying.value
        ],
        onPressed: (index) => controller.toggleTradeType(index == 0),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text("Buy", style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text("Sell", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    ));
  }
}