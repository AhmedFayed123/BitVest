import 'package:dartz/dartz.dart';

import '../../../../core/errors/server_failures.dart';
import '../models/balance_model/Balance_model.dart';

abstract class WalletRepo {
  Future<Either<Failure,BalanceModel>> getBalance();

}