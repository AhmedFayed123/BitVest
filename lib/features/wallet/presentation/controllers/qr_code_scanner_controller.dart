import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerController extends GetxController {
  var scannedCode = ''.obs;

  void onDetect(BarcodeCapture barcodeCapture) {
    if (barcodeCapture.barcodes.isNotEmpty) {
      scannedCode.value = barcodeCapture.barcodes.first.rawValue ?? 'No data';
      Get.back();
    }
  }
}