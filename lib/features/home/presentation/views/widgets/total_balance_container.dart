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
      padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.w),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                kSecondaryTextColor.withOpacity(0.3),
                kCardBackgroundColor.withOpacity(0.9),
              ],
            ),
          ),
          child: Obx(() {
            return Skeletonizer(
              enabled: walletController.isLoading.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance'.tr,
                            style: AppStyles.textStyle19regular.copyWith(
                              color: kPrimaryTextColor.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '\$${walletController.balance.value.data?.balance}',
                            style: AppStyles.textStyle24regular.copyWith(
                              color: kPrimaryTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Obx(() {
                        bool isProfit = walletController.profitLossAmount.value >= 0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${isProfit ? "+" : ""}\$${walletController.profitLossAmount.value.toStringAsFixed(2)}',
                              style: AppStyles.textStyle20regular.copyWith(
                                color: isProfit ? Colors.greenAccent.shade700 : Colors.redAccent.shade700,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${isProfit ? "+" : ""}${walletController.profitLossPercentage.value.toStringAsFixed(2)}%',
                              style: AppStyles.textStyle18regular.copyWith(
                                color: isProfit ? Colors.greenAccent.shade700 : Colors.redAccent.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          title: 'Withdraw'.tr,
                          onPressed: () {},
                          icon: AppIcons.arrow_circle_down,
                          backgroundColor: Colors.redAccent.shade700,
                          iconColor: Colors.white,
                          textColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: ActionButton(
                          title: 'Deposit'.tr,
                          onPressed: () {},
                          icon: AppIcons.arrow_circle_upward,
                          backgroundColor: Colors.greenAccent.shade700,
                          iconColor: Colors.white,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
