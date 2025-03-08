import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/profile/data/models/profile_model/Profile_model.dart';
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
}