import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../wallet/presentation/controllers/wallet_controller.dart';
import 'action_button.dart';

class TotalBalanceContainer extends StatelessWidget {
  const TotalBalanceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.put(WalletController());

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Obx(() {
        final isLoading = walletController.isLoading.value;
        final data = walletController.balance.value?.data;

        final totalBalance = (data?.totalBalanceUsd ?? 0).toDouble();
        final pnlAmount = (data?.totalProfitLossUsd ?? 0).toDouble();
        final pnlPercent = (data?.totalProfitLossPercentage ?? 0).toDouble();
        final usdtBalance = (data?.usdtWalletBalance ?? 0).toDouble();
        final isProfit = pnlAmount >= 0;

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E), // لون خلفية غامق
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 💰 Total Balance & PNL
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total Balance
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Balance', style: AppStyles.textStyle12regular.copyWith(color: Colors.white70)),
                        SizedBox(height: 4.h),
                        Text(
                          '\$${totalBalance.toStringAsFixed(2)}',
                          style: AppStyles.textStyle20regular.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // PNL
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${isProfit ? '+' : '-'}\$${pnlAmount.abs().toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isProfit ? Colors.greenAccent : Colors.redAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '${isProfit ? '+' : '-'}${pnlPercent.abs().toStringAsFixed(2)}%',
                          style: TextStyle(
                            color: isProfit ? Colors.greenAccent : Colors.redAccent,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // 💲 USDT Balance
                Text(
                  'USDT Balance: \$${usdtBalance.toStringAsFixed(2)}',
                  style: AppStyles.textStyle12regular.copyWith(color: Colors.white70),
                ),

                SizedBox(height: 12.h),

                // 🧭 Buttons
                Row(
                  children: [
                    Expanded(
                      child: ActionButton(
                        title: 'Withdraw',
                        onPressed: () {},
                        icon: AppIcons.arrow_circle_down,
                        backgroundColor: Colors.redAccent.shade700,
                        iconColor: Colors.white,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ActionButton(
                        title: 'Deposit',
                        onPressed: () {},
                        icon: AppIcons.arrow_circle_upward,
                        backgroundColor: Colors.greenAccent.shade700,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
