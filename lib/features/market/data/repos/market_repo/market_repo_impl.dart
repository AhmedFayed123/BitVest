import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/market/data/repos/market_repo/market_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/constant/app_endpoints.dart';
import '../../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/services/storage_service.dart';
import '../../models/market_model/Market_model.dart';

class MarketRepoImpl extends MarketRepo{
  @override
  Future<Either<Failure, MarketModel>> getCoinsList() async{
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.cryptoAll,
        token: await sl<StorageService>().getToken(),
      );
      return right(MarketModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}