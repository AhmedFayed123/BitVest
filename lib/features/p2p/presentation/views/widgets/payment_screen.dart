import 'dart:io';

import 'package:bitvest/features/p2p/presentation/views/widgets/trade_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/p2p_controller.dart';

class PaymentScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final int adId;
  final String? paymentDetails;

  PaymentScreen({super.key, required this.adId, this.paymentDetails});

  Future<void> _uploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        Get.find<P2pController>().paymentProofUrl.value = image.path;
        Get.snackbar('Uploaded', 'Payment proof uploaded successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void _submitPayment() {
    final controller = Get.find<P2pController>();
    if (controller.paymentProofUrl.isEmpty) {
      Get.snackbar('Notice', 'Please upload the payment proof first',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    controller.completeAd(adId: adId);
    Get.to(() => TradeConfirmationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Payment Details"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPaymentInstructions(),
            const SizedBox(height: 20),
            _buildPaymentProofUpload(),
            const Spacer(),
            _buildConfirmButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInstructions() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please transfer the amount to the following account:",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              paymentDetails!,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
            const Divider(color: Colors.white),
            const Text(
              "Note: You have 15 minutes to complete the payment.",
              style: TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentProofUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload Proof (Image)",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Obx(() {
          final proofUrl = Get.find<P2pController>().paymentProofUrl.value;
          return GestureDetector(
            onTap: _uploadImage,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                image: proofUrl.isNotEmpty
                    ? DecorationImage(
                    image: FileImage(File(proofUrl)), fit: BoxFit.cover)
                    : null,
              ),
              child: proofUrl.isEmpty
                  ? const Center(
                child: Icon(Icons.upload_file, color: Colors.white, size: 40),
              )
                  : null,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.green[700],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: _submitPayment,
        icon: const Icon(Icons.check, color: Colors.white),
        label: const Text("Sent", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
