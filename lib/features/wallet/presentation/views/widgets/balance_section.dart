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
    final WalletController walletController = Get.put(WalletController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.h),
      child: Obx(() {
        if (walletController.isLoading.value) {
          return Skeletonizer(
            enabled: true,
            child: _buildSkeleton(),
          );
        }

        // ❗️هنا بنجيب الداتا أو نستخدم أصفار لو حصل Error أو لو مفيش داتا
        final data = walletController.balance.value?.data;

        final totalBalance = (data?.totalBalanceUsd ?? 0).toDouble();
        final pnlAmount = (data?.totalProfitLossUsd ?? 0).toDouble();
        final pnlPercent = (data?.totalProfitLossPercentage ?? 0).toDouble();
        final usdtBalance = (data?.usdtWalletBalance ?? 0).toDouble();
        final isProfit = pnlAmount >= 0;

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Colors.white.withOpacity(0.05),
                Colors.white.withOpacity(0.02),
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Balance',
                style: AppStyles.textStyle14regular.copyWith(
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${totalBalance.toStringAsFixed(2)}',
                    style: AppStyles.textStyle24regular.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'USDT',
                    style: AppStyles.textStyle12regular.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              Divider(height: 24.h, color: Colors.white.withOpacity(0.05)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoItem(
                    label: "Today's PNL",
                    value:
                    '${isProfit ? '+' : '-'}\$${pnlAmount.abs().toStringAsFixed(2)}',
                    subValue:
                    '(${isProfit ? '+' : '-'}${pnlPercent.abs().toStringAsFixed(2)}%)',
                    color: isProfit ? Colors.greenAccent : Colors.redAccent,
                  ),
                  _buildInfoItem(
                    label: "USDT Balance",
                    value: '\$${usdtBalance.toStringAsFixed(2)}',
                    color: Colors.blueGrey[300]!,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    String? subValue,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.textStyle12regular.copyWith(
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppStyles.textStyle14semiBold.copyWith(color: color),
        ),
        if (subValue != null)
          Text(
            subValue,
            style: AppStyles.textStyle12regular.copyWith(color: color),
          ),
      ],
    );
  }

  Widget _buildSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 80.w, height: 14.h, color: Colors.white),
        SizedBox(height: 8.h),
        Row(
          children: [
            Container(width: 100.w, height: 26.h, color: Colors.white),
            SizedBox(width: 8.w),
            Container(width: 30.w, height: 16.h, color: Colors.white),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Container(width: 100.w, height: 16.h, color: Colors.white),
            SizedBox(width: 16.w),
            Container(width: 100.w, height: 16.h, color: Colors.white),
          ],
        ),
      ],
    );
  }
}
