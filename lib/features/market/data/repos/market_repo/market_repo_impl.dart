import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/market/data/repos/market_repo/market_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/constant/app_endpoints.dart';
import '../../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/services/storage_service.dart';
import '../../models/favourites_model/Favourites_model.dart';
import '../../models/market_model/Market_model.dart';

class MarketRepoImpl extends MarketRepo{
  @override
  Future<Either<Failure, AllMarketModel>> getCoinsList() async{
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.cryptoAll,
        token: await sl<StorageService>().getToken(),
      );
      print(response.data);
      return right(AllMarketModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MarketModel>> getNewList() async{
    try {
      final response = await DioHelper.getData(
          url: AppEndpoints.cryptoNew,
          token: await sl<StorageService>().getToken(),
    );

    return right(MarketModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavouritesModel>> getFavouriteList() async{
    try {
      final response = await DioHelper.getData(
        url: 'users/${await sl<StorageService>().getId()}/favourites',
        token: await sl<StorageService>().getToken(),
      );

      print("📡 API Response id: ${await sl<StorageService>().getId()}");
      print("📡 API Response token: ${await sl<StorageService>().getToken()}");
      print("📡 API Response Type: ${response.data.runtimeType}");
      print("📡 API Raw Response: ${response.data}");

      if (response.data is String) {
        print("❌ API returned a String instead of JSON!");
        return left(ServerFailure("Invalid response format"));
      }

      return right(FavouritesModel.fromJson(response.data));
    } on DioException catch (e) {
      print("❌ DioException: ${e.response?.data}");
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return left(ServerFailure(e.toString()));
    }

  }
}