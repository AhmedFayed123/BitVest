

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/constant/app_endpoints.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/services/storage_service.dart';
import '../../models/ads_model/Ads_model.dart';
import '../../models/coins_list/Coin_list_model.dart';
import '../../models/news_model/News_model.dart';
import '../../models/notifications_model/notifications_response.dart';
import '../../models/popular_coins_model/Popular_coins_model.dart';
import '../../models/search_model/Search_model.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {

  Dio dio;
  HomeRepoImpl({required this.dio});

  @override
  Future<Either<Failure, NewsModel>> fetchNews() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.news,
        token: await sl<StorageService>().getToken(),
      );
      return right(NewsModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PopularCoinsModel>> fetchPopular() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.popular,
        token: await sl<StorageService>().getToken(),
      );
      print('ooooooooooo');
      print(response.data);

      return right(PopularCoinsModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CoinsListModel>> fetchHighestVolume() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.highestVolume,
        token: await sl<StorageService>().getToken(),
      );
      return right(CoinsListModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CoinsListModel>> fetchHighestChangeDown() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.highestChangeDown,
        token: await sl<StorageService>().getToken(),
      );
      return right(CoinsListModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CoinsListModel>> fetchHighestChangeUp() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.highestChangeUp,
        token: await sl<StorageService>().getToken(),
      );

      print('bbbbbbbbb');
      print(response.data);
      return right(CoinsListModel.fromJson(response.data));
    } on DioException catch (e) {
      print('cccccccccc');
      print('Requesting: ${AppEndpoints.highestChangeUp}');

      print(e);

      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      print('fffffffffff');
      print(e);
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AdsModel>> fetchAds() async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.ads,
        token: await sl<StorageService>().getToken(),
      );
      return right(AdsModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchModel>>> search(String query) async {
    try {
      final response = await DioHelper.getData(
        url: AppEndpoints.search,
        token: await sl<StorageService>().getToken(),
        query: {'query': query},
      );

      if (response.data is List) {
        List<SearchModel> results = (response.data as List)
            .map((item) => SearchModel.fromJson(item))
            .toList();
        return right(results);
      } else {
        return left(ServerFailure("Invalid response format"));
      }
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NotificationsResponse>> fetchNotification() async{
    try {
      final response = await DioHelper.getData(
          url: AppEndpoints.notification,
          token: await sl<StorageService>().getToken(),
    );
      print('Notifications');
      print(response.data);
    return right(NotificationsResponse.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }
}
