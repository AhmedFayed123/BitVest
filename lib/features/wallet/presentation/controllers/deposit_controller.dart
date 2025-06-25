import 'dart:async';
import 'package:get/get.dart';
import 'package:app_links/app_links.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/repo/wallet_repo.dart';
import '../views/widgets/payment_webview_screen.dart';

class DepositController extends GetxController {
  final WalletRepo walletRepo = sl<WalletRepo>();

  var isLoading = false.obs;
  var paymentResult = ''.obs;

  late final AppLinks _appLinks;
  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    _appLinks = AppLinks();

    _handleInitialLink();

    _sub = _appLinks.uriLinkStream.listen((uri) {
      _processUri(uri);
    }, onError: (err) {
      print('Failed to receive app link: $err');
    });
  }

  Future<void> _handleInitialLink() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _processUri(initialUri);
      }
    } catch (e) {
      print('Error getting initial app link: $e');
    }
  }

  void _processUri(Uri uri) async {
    if (uri.scheme == 'myapp' && uri.host == 'payment_result') {
      final hmac = uri.queryParameters['hmac'] ?? '';
      final transactionId = uri.queryParameters['transaction_id'] ?? '';

      paymentResult.value = 'HMAC: $hmac\nTransaction ID: $transactionId';

      Get.snackbar('Payment Result', 'Payment succeeded!\nHMAC: $hmac');

      final result = await walletRepo.sendPaymentCallback(
        success: true,
        hmac: hmac,
      );

      result.fold(
            (failure) => print('Failed to send payment callback: ${failure.message}'),
            (_) => print('Payment callback sent successfully'),
      );
    }
  }

  Future<void> startDeposit(double amount) async {
    isLoading.value = true;

    final result = await walletRepo.deposit(amount);

    result.fold(
          (failure) {
        Get.snackbar('خطأ', failure.message);
        isLoading.value = false;
      },
          (depositModel) async {
        final url = depositModel.iframeUrl;
        if (url != null && url.isNotEmpty) {
          await Get.to(() => PaymentWebViewScreen(url: url));
        } else {
          Get.snackbar('خطأ', 'لم يتم استلام رابط الدفع');
        }
        isLoading.value = false;
      },
    );
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
