// import 'package:get/get.dart';
//
// import '../../../../../core/constant/strings.dart';
// import '../views/reset_password_screen.dart';
//
// class OtpController extends GetxController {
//   var otpCode = ''.obs;
//   var isLoading = false.obs;
//
//   void updateOtp(String code) {
//     otpCode.value = code;
//   }
//
//   void verifyOtp() async {
//     if (otpCode.value.isEmpty || otpCode.value.length < 6) {
//       Get.snackbar('Error', Strings.kOtpValidation, snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     isLoading.value = true;
//     try {
//       await Future.delayed(const Duration(seconds: 2)); // محاكاة استدعاء API
//       Get.snackbar('Success', Strings.otpVerified, snackPosition: SnackPosition.BOTTOM);
//       Get.to(() => const ResetPasswordScreen());
//     } catch (e) {
//       Get.snackbar('Error', Strings.invalidOtp, snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
