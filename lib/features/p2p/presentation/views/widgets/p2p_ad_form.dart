import 'package:bitvest/core/constant/colors.dart';
import 'package:flutter/material.dart';
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
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[700]!),
        ),
        child: Column(
          children: [
            Text(
              isBuying ? 'Post New Buy Advertisement' : 'Post New Sell Advertisement',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Amount Field
            _buildTextField(
              label: 'Amount ($currency)',
              onChanged: controller.amount,
              hint: isBuying ? 'Enter the amount you want to buy' : 'Enter the amount you want to sell',
            ),
            const SizedBox(height: 12),

            // Price Field
            _buildTextField(
              label: 'Price (EGP)',
              onChanged: controller.price,
              hint: isBuying ? 'Enter your buy price' : 'Enter your sell price',
            ),
            const SizedBox(height: 12),

            // Payment Method
            _buildPaymentDropdown(controller),
            const SizedBox(height: 16),

            // Submit Button
            ElevatedButton(
              onPressed: controller.postAd,
              style: ElevatedButton.styleFrom(
                backgroundColor: isBuying ? kPositiveTrendColor : kNegativeTrendColor,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isBuying ? 'Post Buy Advertisement' : 'Post Sell Advertisement',
                style: const TextStyle(fontSize: 16),
              ),
            ),
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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
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
          labelStyle: const TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        items: items.map((e) => DropdownMenuItem(
          value: e,
          child: Text(e, style: const TextStyle(color: Colors.white)),
        )).toList(),
        onChanged: controller.changePaymentMethod,
      );
    });
  }
}
