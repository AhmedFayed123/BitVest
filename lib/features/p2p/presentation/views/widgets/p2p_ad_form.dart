import 'package:bitvest/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/p2p_controller.dart';

class P2pAdForm extends StatelessWidget {
  const P2pAdForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<P2pController>();

    return Obx(() {
      final isBuying = controller.isBuying.value;
      final currency = controller.selectedCurrency.value;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isBuying ? 'Buy Advertisement' : 'Sell Advertisement',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            _buildTextField(
              label: 'Amount ($currency)',
              onChanged: controller.amount,
              hint: 'Ex: 100',
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              label: 'Price (EGP)',
              onChanged: controller.price,
              hint: 'Ex: 15000',
            ),
             SizedBox(height: 10.h),
            _buildPaymentDropdown(controller),
            SizedBox(height: 10.h),
            _buildTextField(
              label: 'Payment Details',
              onChanged: controller.paymentDetails,
              hint: 'Ex: Bank Name, Account Number, etc.',
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: controller.postAd,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isBuying ? kPositiveTrendColor : kNegativeTrendColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isBuying ? 'Post Buy Ad' : 'Post Sell Ad',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildTextField({
    required String label,
    required RxString onChanged,
    String? hint,
  }) {
    return TextField(
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54, fontSize: 12),
        labelStyle: const TextStyle(color: Colors.white70, fontSize: 13),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kPositiveTrendColor),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) => onChanged(value),
    );
  }

  Widget _buildPaymentDropdown(P2pController controller) {
    return Obx(() {
      final current = controller.selectedPayment.value;
      final items = controller.postAdPayments;

      return DropdownButtonFormField<String>(
        value: items.contains(current) ? current : items.first,
        dropdownColor: Colors.grey[900],
        decoration: InputDecoration(
          labelText: 'Payment Method',
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 13),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 13),
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Colors.white)),
                ))
            .toList(),
        onChanged: controller.changePaymentMethod,
      );
    });
  }
}
