import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/wallet/data/models/balance_model/Balance_model.dart';
import 'package:bitvest/features/wallet/data/models/deposit_model/Deposit_model.dart';
import 'package:bitvest/features/wallet/data/models/wallets_model/Wallets_model.dart';
import 'package:bitvest/features/wallet/data/repo/wallet_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../models/transaction_history/transaction_response.dart';

class WalletRepoImpl extends WalletRepo {
  @override
  Future<Either<Failure, BalanceModel>> getBalance() async {
    try {
      final response = await DioHelper.getData(
        url: 'users/${await sl<StorageService>().getId()}/live-wallet',
        token: await sl<StorageService>().getToken(),
      );
      print('888888888');
      print(response.data);
      return right(BalanceModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WalletsModel>> getWallets() async {
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
  Future<Either<Failure, TransactionsResponse>> transactionHistory() async {
    try {
      final Response response = await DioHelper.postData(
        url: AppEndpoints.userTransaction,
        data: {"user_id": await sl<StorageService>().getId()},
        token: await sl<StorageService>().getToken(),
      );
      return right(TransactionsResponse.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPaymentCallback({
    required bool success,
    required String hmac,
  }) async {
    try {
      final token = await sl<StorageService>().getToken();

      final Response response = await DioHelper.postData(
        url: AppEndpoints.paymobCallback,
        data: {
          "success": success,
          "hmac": hmac,
        },
        token: token,
      );

      if (response.statusCode == 200) {
        return right(null);
      } else {
        return left(ServerFailure('فشل إرسال بيانات الدفع للسيرفر'));
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
