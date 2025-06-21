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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[900],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(16),
          fillColor: controller.isBuying.value
              ? kPositiveTrendColor.withOpacity(0.9)
              : kNegativeTrendColor.withOpacity(0.9),
          selectedColor: Colors.white,
          color: Colors.white70,
          selectedBorderColor: Colors.transparent,
          borderColor: Colors.transparent,
          splashColor: Colors.transparent,
          isSelected: [
            controller.isBuying.value,
            !controller.isBuying.value
          ],
          onPressed: (index) => controller.toggleTradeType(index == 0),
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Buy",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Sell",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
