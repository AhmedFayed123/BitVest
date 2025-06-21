import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/server_failures.dart';
import '../../../../google_id.dart';
import '../../models/login_model/Login_model.dart';
import '../../models/login_model/login_request.dart';
import '../../models/login_model/reset_password_request.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest);

  Future<Either<Failure, String>> forgetPassword(String email);

  Future<Either<Failure, String>> resetPassword(
      ResetPasswordRequest resetPasswordRequest);

  Future<Either<Failure, LoginModel>> googleLogin(
      GoogleLoginRequest request);
}
