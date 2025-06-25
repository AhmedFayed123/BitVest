import 'package:bitvest/features/wallet/data/models/transaction_history/transaction_response.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/wallet/data/models/balance_model/Balance_model.dart';
import 'package:bitvest/features/wallet/data/models/wallets_model/Wallets_model.dart';
import 'package:bitvest/features/wallet/data/repo/wallet_repo.dart';

import '../../../../core/services/service_locator.dart';

class WalletController extends GetxController {
  final WalletRepo walletRepo = sl<WalletRepo>();

  var balance = Rxn<BalanceModel>();
  var isLoading = false.obs;
  var errorMessage = RxnString();

  var wallets = WalletsModel().obs;
  var isWalletsLoading = false.obs;
  var walletsErrorMessage = RxnString();


  var transactionHistory = Rxn<TransactionsResponse>();
  var isTransactionLoading = false.obs;
  var transactionErrorMessage = RxnString();



  @override
  void onInit() {
    super.onInit();
    getBalance();
    getWallets();
    getTransactionHistory();
  }

  Future<void> getTransactionHistory() async {
    if (isTransactionLoading.value) return;
    isTransactionLoading.value = true;
    transactionErrorMessage.value = null;

    try {
      Either<Failure, TransactionsResponse> result = await walletRepo.transactionHistory();

      result.fold(
            (failure) {
          transactionErrorMessage.value = failure.message;
          print("❌ Transaction Error: ${failure.message}");
        },
            (data) {
          transactionHistory.value = data;
          print("✅ Transaction History Loaded: ${data.transactions.length} items");
        },
      );
    } catch (e) {
      transactionErrorMessage.value = "حدث خطأ غير متوقع";
    } finally {
      isTransactionLoading.value = false;
    }
  }


  Future<void> _initializeWalletData() async {
    isLoading.value = true;
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
          print("❌ Balance Error: ${failure.message}");
        },
            (data) {
          balance.value = data;
          print('999999999');
          print("✅ Balance Loaded: ${data.data}");
        },
      );
    } catch (e) {
      errorMessage.value = "حدث خطأ غير متوقع";
      print("❌ Exception in getBalance: $e");
    } finally {
      isLoading.value = false;
    }
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
