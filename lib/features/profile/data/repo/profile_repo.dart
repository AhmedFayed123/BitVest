import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/profile/data/models/profile_model/Profile_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepo {
  Future<Either<Failure,ProfileModel>> getProfile();
}