import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/constant/styles.dart';
import '../../controllers/wallet_controller.dart';

class BalanceSection extends StatelessWidget {
  const BalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.find<WalletController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 22.h),
      child: SizedBox(
        width: double.infinity,
        child: Obx(() {
          if (walletController.isLoading.value) {
            return Skeletonizer(
              enabled: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 14.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 120.w,
                        height: 30.h,
                        color: Colors.white,
                      ),
                      SizedBox(width: 3.w),
                      Container(
                        width: 40.w,
                        height: 16.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Container(
                    width: 200.w,
                    height: 16.h,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          } else if (walletController.errorMessage.value != null) {
            return Center(
              child: Text(
                'Error: ${walletController.errorMessage.value}',
                style: AppStyles.textStyle12regular.copyWith(color: Colors.red),
              ),
            );
          } else if (walletController.balance.value.data == null) {
            return Center(
              child: Text(
                'No balance data available',
                style: AppStyles.textStyle12regular,
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: AppStyles.textStyle12regular,
                ),
                SizedBox(height: 4.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${walletController.balance.value.data?.balance ?? '0.00'}',
                      style: AppStyles.textStyle24regular,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '${walletController.balance.value.data?.currency ?? 'USDT'}',
                      style: AppStyles.textStyle12regular,
                    ),
                  ],
                ),
                Obx(() => Text(
                  'Today\'s PNL: ${walletController.profitLossAmount.value >= 0 ? "+" : ""}\$${walletController.profitLossAmount.value.toStringAsFixed(2)} '
                      '(${walletController.profitLossPercentage.value >= 0 ? "+" : ""}${walletController.profitLossPercentage.value.toStringAsFixed(2)}%)',
                  style: AppStyles.textStyle12regular.copyWith(
                    color: walletController.profitLossAmount.value >= 0 ? Colors.green : Colors.red,
                  ),
                )),
              ],
            );
          }
        }),
      ),
    );
  }
}