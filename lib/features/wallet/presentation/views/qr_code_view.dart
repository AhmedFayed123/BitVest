import 'package:bitvest/core/constant/colors.dart';
import 'package:bitvest/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/qr_code_scanner_controller.dart';

class QrCodeView extends StatelessWidget {
  const QrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final QRScannerController controller = Get.put(QRScannerController());

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryTextColor),
          title: Text(
        'Scan QR Code',
        style: AppStyles.textStyle14semiBold,
      )),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (barcodeCapture) => controller.onDetect(barcodeCapture),
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.black54,
              child: Obx(
                () => Text(
                  'Scanned Code: ${controller.scannedCode.value}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
