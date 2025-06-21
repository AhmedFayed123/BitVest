import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletAssetItem extends StatelessWidget {
  final String name;
  final String symbol;
  final double price;
  final double changeRateUsdt;
  final double changeRatePercentage;
  final String balance;
  final String icon;
  final bool isNegative;
  final VoidCallback onTap;

  const WalletAssetItem({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.changeRateUsdt,
    required this.changeRatePercentage,
    required this.balance,
    required this.icon,
    required this.isNegative,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 0.5),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(icon),
              radius: 22.r,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$name ($symbol)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "\$${price.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Bal: $balance",
                        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Change: ${changeRateUsdt.toStringAsFixed(2)} USDT (${changeRatePercentage.toStringAsFixed(2)}%)",
                    style: TextStyle(
                      color: isNegative ? Colors.redAccent : Colors.greenAccent,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.4),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}
