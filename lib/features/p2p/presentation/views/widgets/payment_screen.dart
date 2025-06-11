import 'dart:io';

import 'package:bitvest/features/p2p/presentation/views/widgets/trade_confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/p2p_controller.dart'; // لأختيار الصور

class PaymentScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final int adId;

  PaymentScreen({super.key, required this.adId});

  Future<void> _uploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        Get.snackbar('Success', 'Payment proof uploaded',
            snackPosition: SnackPosition.BOTTOM);
        Get.find<P2pController>().paymentProofUrl.value = image.path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _submitPayment() {
    final controller = Get.find<P2pController>();
    if (controller.paymentProofUrl.isEmpty) {
      Get.snackbar('Error', 'Please upload payment proof first',
          snackPosition: SnackPosition.BOTTOM);
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
        title: const Text("Payment"),
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
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInstructions() {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Transfer the exact amount to:",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text("Bank: CIB", style: TextStyle(fontSize: 16, color: Colors.white)),
            Text("Account: 123456789", style: TextStyle(fontSize: 16, color: Colors.white)),
            Text("Name: Ahmed Mohamed", style: TextStyle(fontSize: 16, color: Colors.white)),
            Divider(color: Colors.white),
            Text("Note: You have 15 minutes to complete payment",
                style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentProofUpload() {
    return Column(
      children: [
        const Text("Upload Payment Proof", style: TextStyle(fontSize: 16, color: Colors.white)),
        const SizedBox(height: 10),
        Obx(() {
          final proofUrl = Get.find<P2pController>().paymentProofUrl.value;
          return Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              image: proofUrl.isNotEmpty
                  ? DecorationImage(
                  image: FileImage(File(proofUrl)),
                  fit: BoxFit.cover)
                  : null,
            ),
            child: proofUrl.isEmpty
                ? IconButton(
              icon: const Icon(Icons.upload, size: 40, color: Colors.white),
              onPressed: _uploadImage,
            )
                : null,
          );
        }),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.green,
        ),
        onPressed: _submitPayment,
        child: const Text("I've Paid",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
