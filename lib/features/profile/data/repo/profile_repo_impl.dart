import 'dart:io';

import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/profile/data/models/profile_model/Profile_model.dart';
import 'package:bitvest/features/profile/data/models/update_profile_model/Update_profile_model.dart';
import 'package:bitvest/features/profile/data/repo/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/dio_helper/dio_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';

class ProfileRepoImpl extends ProfileRepo{
  @override
  Future<Either<Failure, ProfileModel>> getProfile() async{
    try {
      final response = await DioHelper.getData(
          url: 'users/${await sl<StorageService>().getId()}/profile',
    token: await sl<StorageService>().getToken(),
    );
    return right(ProfileModel.fromJson(response.data));
    } on DioException catch (e) {
    return left(ServerFailure.fromDioError(e));
    } catch (e) {
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileModel>> updateProfile(String name, File photo) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "photo": await MultipartFile.fromFile(photo.path, filename: photo.path.split('/').last),
      });

      var response = await DioHelper.postData(
        url: 'users/${await sl<StorageService>().getId()}/update',
        data: formData,
        token: await sl<StorageService>().getToken(),
        isMultipart: true,
      );

      return right(UpdateProfileModel.fromJson(response.data["data"]));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}