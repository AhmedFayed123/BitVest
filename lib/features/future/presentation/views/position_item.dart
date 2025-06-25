import 'package:bitvest/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/models/futures_position_response/futures_position.dart';
import '../controller/future_controller.dart';

class PositionItem extends StatelessWidget {
  const PositionItem({
    super.key,
    required this.position,
    required this.controller,
  });

  final FuturesPosition position;
  final FutureController controller;

  static const _green = Color(0xFF0ECB81);
  static const _red = Color(0xFFE85D65);
  static const _accent = Color(0xFFF0B90B);

  @override
  Widget build(BuildContext context) {
    final isProfit = (position.unrealizedPnl ?? 0) >= 0;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFF101424),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- المعلومات الأساسية ---
          Text(
            '${position.currency} (${position.direction.toUpperCase()})',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
          6.verticalSpace,
          _kv('Entry Price', position.entryPrice),
          _kv('Size', position.size),
          _kv('Leverage', 'x${position.leverage}'),
          _kv('Margin', position.margin),
          Text(
            'Unrealized PnL: ${position.unrealizedPnl?.toStringAsFixed(3) ?? "--"}',
            style: TextStyle(
                color: isProfit ? _green : _red, fontWeight: FontWeight.w600),
          ),
          12.verticalSpace,

          // --- الأزرار ---
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Update PnL'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () async {
                    _showLoader();

                    final res = await controller.updatePosition(position.id);
                    Get.back();

                    final bool ok = RegExp(
                            r'(pnl updated|updated successfully|success)',
                            caseSensitive: false)
                        .hasMatch(res['message'] ?? '');

                    if (ok) {
                      await controller.fetchPositions();

                      Get.snackbar(
                        'Updated',
                        'PnL refreshed',
                        backgroundColor: _green,
                      );
                    } else {
                      Get.snackbar(
                        'Error',
                        res['message'] ?? 'Failed',
                        backgroundColor: _red,
                      );
                    }
                  },
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _red,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () async {
                    final confirm = await _showCloseConfirmDialog();
                    if (confirm != true) return;

                    _showLoader();
                    final res = await controller.closePosition(position.id);
                    Get.back();

                    final bool ok = (res['message'] ?? '')
                        .toString()
                        .toLowerCase()
                        .contains('position closed');

                    if (ok) {
                      await controller.fetchPositions();

                      Get.snackbar('Closed', 'Position closed ✅',
                          backgroundColor: _green);
                    } else {
                      Get.snackbar('Error', res['message'] ?? 'Failed',
                          backgroundColor: _red);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool?> _showCloseConfirmDialog() {
    return Get.dialog<bool>(
      Dialog(
        backgroundColor: const Color(0xFF101424),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 50),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  size: 40, color: Color(0xFFF0B90B)),
              const SizedBox(height: 16),
              const Text(
                'Close position?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to close this position?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => Get.back(result: false),
                      child: Text(
                        'Cancel',
                        style: AppStyles.textStyle12regular,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFE85D65), // _red
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => Get.back(result: true),
                      child: Text(
                        'Close',
                        style: AppStyles.textStyle12regular,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black54,
    );
  }

  void _showLoader() {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF101424),
        insetPadding: EdgeInsets.symmetric(horizontal: 80.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              16.verticalSpace,
              Text(
                'Please wait...',
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black54,
    );
  }

  Widget _kv(String k, dynamic v) => Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Text(
          '$k: $v',
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      );
}
