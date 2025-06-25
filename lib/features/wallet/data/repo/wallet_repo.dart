import 'package:bitvest/features/wallet/data/models/deposit_model/Deposit_model.dart';
import 'package:bitvest/features/wallet/data/models/wallets_model/Wallets_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/balance_model/Balance_model.dart';
import '../models/transaction_history/transaction_response.dart';

abstract class WalletRepo {
  Future<Either<Failure,BalanceModel>> getBalance();
  Future<Either<Failure,WalletsModel>> getWallets();
  Future<Either<Failure,DepositModel>> deposit(double amount);
  Future<Either<Failure,TransactionsResponse>> transactionHistory();
  Future<Either<Failure, void>> sendPaymentCallback({
    required bool success,
    required String hmac,
  });
}