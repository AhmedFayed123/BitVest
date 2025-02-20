import 'package:bitvest/features/auth/register/data/repos/signup_repo/signup_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/constant/app_endpoints.dart';
import '../../../../../../core/errors/server_failures.dart';
import '../../../../../../core/network/dio_helper/dio_helper.dart';
import '../../models/register_models.dart';

class SignupRepoImpl extends SignupRepo {
  @override
  Future<Either<Failure, SignupModel>> signup(
      SignupRequest signupRequest) async {
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.signupUrl,
        data: signupRequest,
      );
      return right(SignupModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyOtp(
      VerifyOtpRequest verifyOtpRequest) async {
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.verifyOtpUrl,
        data: verifyOtpRequest,
      );
      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> setPassword(
      SetPasswordRequest setPasswordRequest) async {
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.setPasswordUrl,
        data: setPasswordRequest,
      );
      return right(response.data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
