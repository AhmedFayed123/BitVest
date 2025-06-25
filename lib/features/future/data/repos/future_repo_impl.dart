import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/future/data/models/available_coins/Available_coins.dart';
import 'package:bitvest/features/future/data/models/future_wallet/Future_wallet.dart';
import 'package:bitvest/features/future/data/models/position_open_request/Position_open_request.dart';
import 'package:bitvest/features/future/data/repos/future_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../models/futures_position_response/futures_position_response.dart';

class FutureRepoImpl extends FutureRepo {
  @override
  Future<Either<Failure, FutureWallet>> fetchFutureWallet() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.futureWallet,
        token: await sl<StorageService>().getToken(),
      );
      return right(FutureWallet.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AvailableCoins>> fetchAvailableCoins() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.futuresAvailableCoins,
        token: await sl<StorageService>().getToken(),
      );
      return right(AvailableCoins.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> transferFutures({
    required String currency,
    required double amount,
  }) async {
    try {
      final token = await sl<StorageService>().getToken();

      final response = await DioHelper.postData(
        url: AppEndpoints.futuresTransfer,
        data: {
          "user_id": await sl<StorageService>().getId(),
          "currency": currency,
          "amount": amount,
        },
        token: token,
      );

      print(
          "Sent Data: user_id=${await sl<StorageService>().getId()}, currency=$currency, amount=$amount");
      print("Response Data: ${response.data}");
      print("Status Code: ${response.statusCode}");

      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> transferFuturesSpot(
      {required String currency, required double amount}) async {
    try {
      final token = await sl<StorageService>().getToken();

      final response = await DioHelper.postData(
        url: AppEndpoints.futuresTransferSpot,
        data: {
          "user_id": await sl<StorageService>().getId(),
          "currency": currency,
          "amount": amount,
        },
        token: token,
      );

      print(
          "Sent Data: user_id=${await sl<StorageService>().getId()}, currency=$currency, amount=$amount");
      print("Response Data: ${response.data}");
      print("Status Code: ${response.statusCode}");

      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FuturesPositionResponse>> fetchFuturePositions() async{
    try {
      final response = await DioHelper.getData(
          url: AppEndpoints.futuresPositions,
          token: await sl<StorageService>().getToken(),
    );
    return right(FuturesPositionResponse.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> closePosition(int positionId) async {
    try {
      final token = await sl<StorageService>().getToken();

      final response = await DioHelper.postData(
        url: "${AppEndpoints.futuresPositionsClose}/$positionId",
        data: {},
        token: token,
      );

      print("❌ Closing Position ID: $positionId");
      print("📥 Response: ${response.data}");

      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, Map<String, dynamic>>> openPosition(PositionOpenRequest positionOpenRequest) async {
    try {
      final token = await sl<StorageService>().getToken();

      final response = await DioHelper.postData(
        url: AppEndpoints.futuresPositionsOpen,
        data: positionOpenRequest.toJson(),
        token: token,
      );

      print("🔓 Open Position Data Sent: ${positionOpenRequest.toJson()}");
      print("📥 Response: ${response.data}");

      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failure, Map<String, dynamic>>> updatePosition(int positionId) async {
    try {
      final token = await sl<StorageService>().getToken();

      final response = await DioHelper.postData(
        url: "${AppEndpoints.futuresPositionsUpdatePnl}/$positionId",
        data: {},
        token: token,
      );

      print("🔄 Updating PnL for Position ID: $positionId");
      print("📥 Response: ${response.data}");

      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}
