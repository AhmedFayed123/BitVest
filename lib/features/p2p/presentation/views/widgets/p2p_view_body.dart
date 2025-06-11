import 'package:bitvest/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/p2p_controller.dart';
import 'p2p_ad_form.dart';
import 'p2p_toggle_buttons.dart';
import 'p2p_trader_card.dart';

class P2pViewBody extends StatelessWidget {
  const P2pViewBody({super.key});

  // Helper method to build filter sections
  Widget _buildFilterSection({required String title, required Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,  // تصغير حجم الخط
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),  // تقليل المسافة بين العنوان والعنصر
          child,
          SizedBox(height: 4.h),  // تقليل المسافة بين العنصر والـ SizedBox التالي
        ],
      ),
    );
  }

  // Helper method to build currency dropdown
  Widget _buildCurrencyDropdown(P2pController controller) {
    return Obx(() => _CustomDropdown(
      value: controller.selectedCurrency.value,
      items: controller.currencies,
      onChanged: controller.changeCurrency,
    ));
  }

  // Helper method to build payment dropdown
  Widget _buildPaymentDropdown(P2pController controller) {
    return Obx(() {
      final current = controller.selectedPayment.value;
      final items = controller.availablePayments;
      final value = items.contains(current) ? current : items.first;

      return _CustomDropdown(
        value: value,
        items: items,
        onChanged: controller.changePaymentMethod,
      );
    });
  }

  // Helper method to build post ad button
  Widget _buildPostAdButton(P2pController controller) {
    return Obx(
          () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: ElevatedButton(
            onPressed: () => controller.isAdPosting.toggle(),
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.isBuying.value
                  ? kPositiveTrendColor
                  : kNegativeTrendColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),  // تقليل padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              controller.isAdPosting.value
                  ? 'Cancel'
                  : controller.isBuying.value
                  ? 'Post Buy Advertisement'
                  : 'Post Sell Advertisement',
              style: const TextStyle(fontSize: 14),  // تقليل حجم الخط
            )),
      ),
    );
  }

  // Helper method to build traders list
  Widget _buildTradersList(P2pController controller) {
    return Obx(() {
      return RefreshIndicator(
        color: kAmberColor,
        backgroundColor: kBlackColor,
        strokeWidth: 3,
        onRefresh: controller.refreshTraders,
        child: controller.filteredTraders.isEmpty
            ? ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "No traders found",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
          ],
        )
            : ListView.separated(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.filteredTraders.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final trader = controller.filteredTraders[index];
            return P2pTraderCard(trader: trader);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(P2pController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Trade Type Toggle
        SizedBox(height: 15.h),
        const P2pToggleButtons(),

        // Currency Filter
        _buildFilterSection(
          title: 'Currency',
          child: _buildCurrencyDropdown(controller),
        ),

        // Payment Filter
        _buildFilterSection(
          title: 'Payment Method',
          child: _buildPaymentDropdown(controller),
        ),

        // Post Ad Button
        _buildPostAdButton(controller),

        // Ad Form (if posting)
        Obx(() => controller.isAdPosting.value
            ? const P2pAdForm()
            : const SizedBox()),

        const SizedBox(height: 20),

        // Traders List wrapped with RefreshIndicator
        Expanded(
          child: RefreshIndicator(
            color: kAmberColor,
            backgroundColor: kBlackColor,
            onRefresh: controller.refreshTraders,
            child: Obx(() {
              return controller.filteredTraders.isEmpty
                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "No traders found",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              )
                  : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                itemCount: controller.filteredTraders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final trader = controller.filteredTraders[index];
                  return P2pTraderCard(trader: trader);
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _CustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _CustomDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        dropdownColor: Colors.grey[900],
        iconEnabledColor: Colors.white,
        underline: const SizedBox(),
        items: items
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e, style: const TextStyle(color: Colors.white)),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
