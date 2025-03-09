import 'package:bitvest/features/trade/data/models/Coin_data_model.dart';
import 'package:bitvest/features/trade/data/models/buy_sell_model/Buy_sell_model.dart';
import 'package:bitvest/features/trade/data/repos/trade_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/errors/server_failures.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../models/put_favourites_model/Put_favourites_model.dart';

class TradeRepoImpl extends TradeRepo {
  @override
  Future<Either<Failure, CoinDataModel>> getCoinDetails(String id) async {
    try {
      final response = await DioHelper.getData(
        url: "${AppEndpoints.crypto}/$id",
        token: await sl<StorageService>().getToken(),
      );
      return right(CoinDataModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BuySellModel>> buyCrypto(
      String currency, double amount) async {
    try {
      final response = await DioHelper.postData(
        url: AppEndpoints.buyCrypto,
        token: await sl<StorageService>().getToken(),
        data: {"currency": currency, "amount": amount},
      );
      print('vvvvvvvvvvv');
      print(response.data);
      return right(BuySellModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BuySellModel>> sellCrypto(
      String currency, double amount) async{
    try {
      final response = await DioHelper.postData(
          url: AppEndpoints.sellCrypto,
          token: await sl<StorageService>().getToken(),
    data: {"currency": currency, "amount": amount},
    );
      print('hhhhhhhhhhh');
      print(response.data);
    return right(BuySellModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PutFavouritesModel>> putFavourites(String currency) async{
    try {
      final response = await DioHelper.postData(
          url: AppEndpoints.putFavourites,
          token: await sl<StorageService>().getToken(),
        data: {"currency": currency,},

    );

    return right(PutFavouritesModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteFavourite(String id) async{
    try {
      final response = await DioHelper.deleteData(
          url: 'users/${await sl<StorageService>().getId()}/favourites/$id',
          token: await sl<StorageService>().getToken(),
    );
    return right(response.data);
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }
}
