import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/wallet/data/models/balance_model/Balance_model.dart';
import 'package:bitvest/features/wallet/data/repo/wallet_repo.dart';

import '../../../../core/services/service_locator.dart';

class WalletController extends GetxController {
  final WalletRepo walletRepo = sl<WalletRepo>();

  var balance = BalanceModel().obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();

  var previousBalance = "0.0".obs;
  var profitLossAmount = 0.0.obs;
  var profitLossPercentage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getBalance();
  }

  Future<void> getBalance() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      Either<Failure, BalanceModel> result = await walletRepo.getBalance();

      result.fold(
            (failure) => errorMessage.value = failure.message,
            (data) {
          double newBalance = double.tryParse(data.data?.balance ?? "0.0") ?? 0.0;
          double oldBalance = double.tryParse(previousBalance.value) ?? 0.0;

          double changeAmount = newBalance - oldBalance;
          double changePercentage = (oldBalance == 0) ? 0 : (changeAmount / oldBalance) * 100;

          profitLossAmount.value = changeAmount;
          profitLossPercentage.value = changePercentage;
          previousBalance.value = newBalance.toString(); // تخزين الرصيد الجديد
          balance.value = data;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
