import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/colors.dart'; // kBackgroundColor
import '../../../../core/components/widgets/circle_loading.dart';
import '../../data/models/position_open_request/Position_open_request.dart';
import '../controller/future_controller.dart';

class PositionScreen extends StatelessWidget {
  const PositionScreen({super.key, required this.currency});
  final String currency;

  /// Binance‑style brand colours
  static const _green = Color(0xFF0ECB81);
  static const _red = Color(0xFFE85D65);
  static const _accent = Color(0xFFF0B90B); // yellow accent

  @override
  Widget build(BuildContext context) {
    final c = Get.find<FutureController>();
    final RxInt leverage = 10.obs;
    final RxString direction = 'long'.obs;
    final sizeCtl = TextEditingController();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Open $currency',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)),
      ),
      body: Obx(
            () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('Direction'),
              Row(children: [
                _dirBtn('Long', _green, direction),
                12.horizontalSpace,
                _dirBtn('Short', _red, direction),
              ]),
              32.verticalSpace,
              _label('Leverage  (${leverage.value}×)'),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 5,
                  activeTrackColor: _accent,
                  inactiveTrackColor: Colors.white24,
                  thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 8),
                  thumbColor: _accent,
                  overlayColor: _accent.withOpacity(.2),
                  valueIndicatorColor: _accent,
                ),
                child: Slider(
                  min: 1,
                  max: 100,
                  divisions: 99,
                  value: leverage.value.toDouble(),
                  label: '${leverage.value}×',
                  onChanged: (v) => leverage.value = v.round(),
                ),
              ),
              32.verticalSpace,
              _label('Size'),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF101424),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: TextField(
                  controller: sizeCtl,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.1',
                    hintStyle: TextStyle(color: Colors.white30),
                  ),
                ),
              ),
              48.verticalSpace,
              SizedBox(
                width: double.infinity,
                child: Obx(
                      () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      backgroundColor:
                      direction.value == 'long' ? _green : _red,
                      padding: EdgeInsets.symmetric(vertical: 18.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    onPressed: () async {
                      final raw = sizeCtl.text.trim();
                      final sizeVal = double.tryParse(raw);
                      if (sizeVal == null || sizeVal <= 0) {
                        Get.snackbar('Error', 'Enter valid size',
                            backgroundColor: _red);
                        return;
                      }

                      final req = PositionOpenRequest(
                        currency: currency,
                        size: sizeVal,
                        leverage: leverage.value,
                        price: null,
                        direction: direction.value,
                      );

                      Get.dialog(const Center(child: CircleLoading()),
                          barrierDismissible: false);
                      final res = await c.openPosition(req);
                      Get.back(); // close loader

                      final bool ok = res['success'] == true ||
                          res['open_positions'] != null ||
                          (res['message']
                              ?.toString()
                              .toLowerCase()
                              .contains('success') ??
                              false);

                      if (ok) {
                        Get.back(); // pop PositionScreen
                        Get.snackbar('Opened', 'Position added',
                            backgroundColor: _green);
                      } else {
                        Get.snackbar('Error', res['message'] ?? 'Failed',
                            backgroundColor: _red);
                      }
                    },
                    child: Text(
                      'OPEN POSITION',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String txt) => Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: Text(txt,
        style: TextStyle(
            color: Colors.white70,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600)),
  );

  Widget _dirBtn(String label, Color color, RxString dir) => Expanded(
    child: GestureDetector(
      onTap: () => dir.value = label.toLowerCase(),
      child: Obx(
            () => AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 46.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: dir.value == label.toLowerCase()
                ? LinearGradient(
              colors: [
                color.withOpacity(.9),
                color.withOpacity(.7),
              ],
            )
                : null,
            color: dir.value == label.toLowerCase()
                ? null
                : const Color(0xFF101424),
            border: Border.all(
                color: dir.value == label.toLowerCase()
                    ? Colors.transparent
                    : Colors.white24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                label == 'Long'
                    ? Icons.trending_up
                    : Icons.trending_down,
                size: 18.sp,
                color: Colors.white,
              ),
              6.horizontalSpace,
              Text(label,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp)),
            ],
          ),
        ),
      ),
    ),
  );
}
