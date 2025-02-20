import 'package:bitvest/core/errors/server_failures.dart';

import 'package:bitvest/features/auth/login/data/models/login_model/Login_model.dart';

import 'package:bitvest/features/auth/login/data/models/login_model/login_request.dart';
import 'package:bitvest/features/auth/login/data/models/login_model/reset_password_request.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/constant/app_endpoints.dart';
import '../../../../../../core/network/dio_helper/dio_helper.dart';
import 'login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest) async {
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.loginUrl,
        data: loginRequest,
      );
      return right(LoginModel.fromJson(response.data));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.forgetPassword,
        data: {"email": email},
      );
      return right(response.data["message"]);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(ResetPasswordRequest resetPasswordRequest) async{
    try {
      final Response response = await DioHelper.postDataWithoutToken(
        url: AppEndpoints.resetPassword,
        data: resetPasswordRequest,
      );
      return right(response.data["message"]);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
