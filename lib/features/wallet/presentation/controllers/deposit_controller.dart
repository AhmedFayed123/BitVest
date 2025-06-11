import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../core/services/service_locator.dart';
import '../../data/repo/wallet_repo.dart';
import '../views/widgets/payment_webview_screen.dart';

class DepositController extends GetxController {
  final WalletRepo walletRepo = sl<WalletRepo>();


  var isLoading = false.obs;

  Future<void> startDeposit(double amount) async {
    isLoading.value = true;

    final result = await walletRepo.deposit(amount);

    result.fold(
          (failure) {
        Get.snackbar('خطأ', failure.message);
      },
          (depositModel) {
        final url = depositModel.iframeUrl;
        if (url != null && url.isNotEmpty) {
          Get.to(() => PaymentWebViewScreen(url: url));
        } else {
          Get.snackbar('خطأ', 'لم يتم استلام رابط الدفع');
        }
      },
    );

    isLoading.value = false;
  }
}
