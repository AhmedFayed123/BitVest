import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/wallet/data/models/balance_model/Balance_model.dart';
import 'package:bitvest/features/wallet/data/models/wallets_model/Wallets_model.dart';
import 'package:bitvest/features/wallet/data/repo/wallet_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/service_locator.dart';

class WalletController extends GetxController {
  final WalletRepo walletRepo = sl<WalletRepo>();

  var balance = BalanceModel().obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();

  var wallets = WalletsModel().obs;
  var isWalletsLoading = false.obs;
  var walletsErrorMessage = RxnString();

  var previousBalance = "0.0".obs;
  var profitLossAmount = 0.0.obs;
  var profitLossPercentage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadPreviousBalance();
    getBalance();
    getWallets();
  }

  Future<void> _initializeWalletData() async {
    isLoading.value = true;
    await loadPreviousBalance();
    await getBalance();
    await getWallets();
    isLoading.value = false;
  }

  Future<void> refreshData() async {
    await _initializeWalletData();
  }

  Future<void> getBalance() async {
    if (isLoading.value) return;
    isLoading.value = true;
    errorMessage.value = null;

    try {
      Either<Failure, BalanceModel> result = await walletRepo.getBalance();

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
        },
        (data) async {
          double newBalance =
              double.tryParse(data.data?.balance ?? "0.0") ?? 0.0;
          double oldBalance = double.tryParse(previousBalance.value) ?? 0.0;

          double changeAmount = newBalance - oldBalance;
          double changePercentage = (oldBalance > 0)
              ? (changeAmount / oldBalance) * 100
              : (changeAmount == 0 ? 0 : 100);

          profitLossAmount.value = changeAmount;
          profitLossPercentage.value = changePercentage;

          balance.value = data;

          previousBalance.value = newBalance.toString();
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('previous_balance', previousBalance.value);
        },
      );
    } catch (e) {
      errorMessage.value = "حدث خطأ غير متوقع";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPreviousBalance() async {
    final prefs = await SharedPreferences.getInstance();
    previousBalance.value = prefs.getString('previous_balance') ?? "0.0";
  }

  Future<void> getWallets() async {
    if (isWalletsLoading.value) return;
    isWalletsLoading.value = true;
    walletsErrorMessage.value = null;

    try {
      Either<Failure, WalletsModel> result = await walletRepo.getWallets();

      result.fold(
            (failure) {
          walletsErrorMessage.value = failure.message;
          print("❌ Error: ${failure.message}");
        },
            (data) {
          wallets.value = data;
          print("✅ Wallets updated: ${wallets.value.data}");
        },
      );
    } catch (e) {
      walletsErrorMessage.value = "An unexpected error occurred";
    } finally {
      isWalletsLoading.value = false;
    }
  }

}
