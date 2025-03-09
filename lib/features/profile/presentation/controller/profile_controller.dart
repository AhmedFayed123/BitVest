import 'dart:io';
import 'package:bitvest/features/profile/data/models/update_profile_model/Update_profile_model.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:bitvest/core/errors/server_failures.dart';
import 'package:bitvest/features/profile/data/models/profile_model/Profile_model.dart';
import 'package:bitvest/features/profile/data/repo/profile_repo.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/service_locator.dart';

class ProfileController extends GetxController {
  final ProfileRepo profileRepo = sl<ProfileRepo>();

  var profile = Rxn<ProfileModel>();
  var updateProfileResponse = Rxn<UpdateProfileModel>();
  var isLoading = false.obs;
  var errorMessage = RxnString();
  var isUpdating = false.obs;
  var selectedImage = Rxn<File>();

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

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> updateProfile(String name) async {
    try {
      isUpdating.value = true;
      errorMessage.value = null;

      File? imageFile = selectedImage.value;

      Either<Failure, UpdateProfileModel> result =
      await profileRepo.updateProfile(name, imageFile!);

      result.fold(
            (failure) {
          errorMessage.value = failure.message;
          Get.snackbar("Error", failure.message,
              snackPosition: SnackPosition.BOTTOM, backgroundColor: Get.theme.colorScheme.error);
        },
            (data) {
          updateProfileResponse.value = data;
          Get.snackbar("Success", "Profile updated successfully",
              snackPosition: SnackPosition.BOTTOM, backgroundColor: Get.theme.colorScheme.primary);
          getProfile();
        },
      );
    } finally {
      isUpdating.value = false;
    }
  }
}
