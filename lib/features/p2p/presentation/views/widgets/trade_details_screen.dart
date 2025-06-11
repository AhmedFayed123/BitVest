import 'package:bitvest/features/p2p/presentation/views/widgets/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/p2p_controller.dart';

class TradeDetailsScreen extends StatelessWidget {

  const TradeDetailsScreen({super.key,required this.id, required this.price, required this.paymentMethod, required this.traderName, required this.limit, required this.currency});

  final int id;
  final String price;
  final String paymentMethod;
  final String traderName;
  final String limit;
  final String currency;



  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<P2pController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          controller.isBuying.value
              ? "Buy ${currency}"
              : "Sell ${currency}",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserCard(),
            const SizedBox(height: 20),
            _buildTradeSummary(controller),
            const SizedBox(height: 20),
            _buildAmountInput(controller),
            const Spacer(),
            _buildActionButton(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.white24,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          traderName ,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTradeSummary(P2pController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trade Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const Divider(color: Colors.white54),
        _buildDetailRow("Price", "${price} EGP"),
        _buildDetailRow("Payment Method", paymentMethod),
        _buildDetailRow("Limit",
            "{0 - $limit} EGP"),
      ],
    );
  }

  Widget _buildAmountInput(P2pController controller) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Enter Amount (${controller.selectedCurrency.value})",
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[900],
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) => controller.tradeAmount.value = value,
    );
  }

  Widget _buildActionButton(P2pController controller) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor:
          controller.isBuying.value ? Colors.green[700] : Colors.blue[700],
        ),
        onPressed: () => _proceedToPayment(controller),
        child: Text(
          controller.isBuying.value ? "Pay Now" : "Confirm Receipt",
          style: const TextStyle(fontSize: 16,color: Colors.white),
        ),
      ),
    );
  }

  void _proceedToPayment(P2pController controller) async {
    if (controller.tradeAmount.value.isEmpty) {
      Get.snackbar("Error", "Please enter amount",
          backgroundColor: Colors.red[900], colorText: Colors.white);
      return;
    }

    final double? amount = double.tryParse(controller.tradeAmount.value);
    if (amount == null || amount <= 0) {
      Get.snackbar("Error", "Invalid amount",
          backgroundColor: Colors.red[900], colorText: Colors.white);
      return;
    }

    await controller.acceptAd(amount: amount, adId: id);

    // بعد نجاح القبول، روح لصفحة الدفع أو أي حاجة تانية
    Get.to(() =>  PaymentScreen(adId: id,));
  }

}
