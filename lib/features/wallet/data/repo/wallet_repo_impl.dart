import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/wallet/data/models/balance_model/Balance_model.dart';
import 'package:bitvest/features/wallet/data/models/deposit_model/Deposit_model.dart';
import 'package:bitvest/features/wallet/data/models/transaction_history/Transaction_history.dart';
import 'package:bitvest/features/wallet/data/models/wallets_model/Wallets_model.dart';
import 'package:bitvest/features/wallet/data/repo/wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';

class WalletRepoImpl extends WalletRepo {
  @override
  Future<Either<Failure, BalanceModel>> getBalance() async {
    try {
      final response = await DioHelper.getData(
        url: 'users/${await sl<StorageService>().getId()}/balance',
        token: await sl<StorageService>().getToken(),
      );
      print(response.data);
      return right(BalanceModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WalletsModel>> getWallets() async{
    try {
      final response = await DioHelper.getData(
          url: 'users/${await sl<StorageService>().getId()}/wallets',
    token: await sl<StorageService>().getToken(),
    );
      print('///////////x');
      print(response.data);
    return right(WalletsModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DepositModel>> deposit(double amount) async {
    try {
      final token = await sl<StorageService>().getToken();

      final Response response = await DioHelper.postData(
        url: AppEndpoints.deposit,
        data: {"amount": amount},
        token: token,
      );

      if (response.statusCode == 200) {
        final model = DepositModel.fromJson(response.data);
        return right(model);
      } else {
        return left(ServerFailure('فشل بدء عملية الدفع'));
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransactionHistory>> transactionHistory() async{
    try {
      final Response response = await DioHelper.postData(
        url: AppEndpoints.userTransaction,
        data: {"user_id": await sl<StorageService>().getId()},
        token: await sl<StorageService>().getToken(),
      );
      return right(TransactionHistory.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}
