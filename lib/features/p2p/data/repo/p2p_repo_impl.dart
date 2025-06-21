import 'dart:io';

import 'package:bitvest/features/p2p/data/models/accept_ad_model/Accept_ad_model.dart';
import 'package:bitvest/features/p2p/data/models/edit/edit_model/Edit_model.dart';
import 'package:bitvest/features/p2p/data/models/get_ads_model/Get_ads_model.dart';
import 'package:bitvest/features/p2p/data/models/p2p_complete_model/P2p_complete_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/app_endpoints.dart';
import '../../../../core/errors/server_failures.dart';
import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../models/edit/edit_request/Edit_request.dart';
import '../models/p2p_ad_response/P2p_ad_response.dart';
import '../models/p2p_request/P2p_request.dart';
import 'p2p_repo.dart';

class P2pRepoImpl extends P2pRepo {
  @override
  Future<Either<Failure, P2pAdResponse>> createBuyAd(P2pRequest p2pRequest) async {
    try {
      final Response response = await DioHelper.postData(
        url: AppEndpoints.createBuyAd,
        data: p2pRequest,
        token: await sl<StorageService>().getToken(),
      );
      return right(P2pAdResponse.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, P2pAdResponse>> createSellAd(P2pRequest p2pRequest) async {
    try {
      final Response response = await DioHelper.postData(
        url: AppEndpoints.createSellAd,
        data: p2pRequest,
        token: await sl<StorageService>().getToken(),

      );
      return right(P2pAdResponse.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetAdsModel>> getBuyAd() async{
    try {
      final response = await DioHelper.getData(
          url: AppEndpoints.p2pGetBuyAd,
          token: await sl<StorageService>().getToken(),
    );
    print(response.data);
    return right(GetAdsModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetAdsModel>> getSellAd() async{
    try {
      final response = await DioHelper.getData(
          url: AppEndpoints.p2pGetSellAd,
          token: await sl<StorageService>().getToken(),
    );
    print(response.data);
    return right(GetAdsModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AcceptAdModel>> postAcceptAd(double amount,int id) async{
    try {
      final Response response = await DioHelper.postData(
          url: "${AppEndpoints.p2pStart}$id",
        data: {"amount": amount},
          token: await sl<StorageService>().getToken(),
    );
    return right(AcceptAdModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, P2pCompleteModel>> p2pCompleteAd(File photo,int id) async{
    try {
      FormData formData = FormData.fromMap({
        "payment_proof": await MultipartFile.fromFile(photo.path, filename: photo.path.split('/').last),
      });

      var response = await DioHelper.postData(
          url: "${AppEndpoints.p2pComplete}$id",
    data: formData,
    token: await sl<StorageService>().getToken(),
    isMultipart: true,
    );

    return right(P2pCompleteModel.fromJson(response.data));
    } catch (e) {
    if (e is DioException) {
    return left(ServerFailure.fromDioError(e));
    }
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetAdsModel>> getUserAds() async{
    try {
      final response = await DioHelper.getData(
          url: AppEndpoints.p2pUserAds,
          token: await sl<StorageService>().getToken(),
    );
      print('===============');
      print(response.data);
    return right(GetAdsModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditModel>> editBuyAd(EditRequest editRequest) async {
    final token = await sl<StorageService>().getToken();
    try {
      final response = await DioHelper.postData(
          url: "${AppEndpoints.editBuyAd}${editRequest.id}",  // مثلا رابط + id
          data: editRequest.toJson(),
        token: token,
    );
      return right(EditModel.fromJson(response.data));
    } on DioException catch (e) {

      print("TOKEN: $token");

      return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditModel>> editSellAd(EditRequest editRequest) async{
    final token = await sl<StorageService>().getToken();

    print('URL: ${AppEndpoints.editSellAd}${editRequest.id}');
    print('Token: $token');
    print('Request Data: ${editRequest.toJson()}');
    try {
      final response = await DioHelper.postData(
          url: "${AppEndpoints.editSellAd}${editRequest.id}",
          data: editRequest.toJson(),
        token: token,
    );
      print('ooooooooooo');
      return right(EditModel.fromJson(response.data));
    } on DioException catch (e) {
      print("${AppEndpoints.editSellAd}${editRequest.id}");
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, String>> deleteBuyAd(int adId) async {
    try {
      final response = await DioHelper.deleteData(
        url: "${AppEndpoints.deleteBuyAd}$adId",
        token: await sl<StorageService>().getToken(),
      );
      return right(response.data["message"]);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteSellAd(int adId) async {
    try {
      final response = await DioHelper.deleteData(
        url: "${AppEndpoints.deleteSellAd}$adId",
        token: await sl<StorageService>().getToken(),
      );
      return right(response.data["message"]);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}
