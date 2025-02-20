import 'package:bitvest/features/auth/register/data/models/register_models.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/server_failures.dart';

abstract class SignupRepo {
  Future<Either<Failure, SignupModel>> signup(SignupRequest signupRequest);
  Future<Either<Failure, Map<String,dynamic>>> verifyOtp(VerifyOtpRequest verifyOtpRequest);
  Future<Either<Failure, Map<String,dynamic>>> setPassword(SetPasswordRequest setPasswordRequest);

}