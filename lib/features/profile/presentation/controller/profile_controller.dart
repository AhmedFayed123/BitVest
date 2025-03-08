import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/profile/data/models/profile_model/Profile_model.dart';
import 'package:bitvest/features/profile/data/repo/profile_repo.dart';

import '../../../../core/services/service_locator.dart';

class ProfileController extends GetxController {
  final ProfileRepo profileRepo = sl<ProfileRepo>();

  var profile = Rxn<ProfileModel>();
  var isLoading = false.obs;
  var errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      Either<Failure, ProfileModel> result = await profileRepo.getProfile();

      result.fold(
            (failure) => errorMessage.value = failure.message,
            (data) => profile.value = data,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
