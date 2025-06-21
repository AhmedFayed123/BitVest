import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/strings.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../home/presentation/views/home_view.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../google_id.dart';
import '../../data/models/login_model/Login_model.dart';
import '../../data/models/login_model/login_request.dart';
import '../../data/repos/login_repo/login_repo.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  Future<void> loginWithGoogle(String idToken) async {
    isLoading.value = true;

    try {
      final googleRequest = GoogleLoginRequest(idToken: idToken);

      Either<Failure, LoginModel> result = await sl<LoginRepo>().googleLogin(googleRequest);

      isLoading.value = false;

      result.fold(
            (failure) {
          Get.snackbar('Error', failure.message,
              backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        },
            (loginModel) async {
          if (loginModel.token != null && loginModel.user != null) {
            // حفظ بيانات المستخدم
            await sl<StorageService>().saveUserSession(
              token: loginModel.token!,
              userName: loginModel.user!.name ?? '',
              userEmail: loginModel.user!.email ?? '',
              userId: loginModel.user!.id ?? 0,
            );

            Get.snackbar('Success', 'Login successful',
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM);

            // التوجيه للـ HomeView وإزالة جميع الشاشات السابقة
            Get.offAll(() => HomeView());
          } else {
            Get.snackbar('Error', loginModel.message ?? "Login failed",
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM);
          }
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred: $e',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final loginRequest = LoginRequest(
        email: emailController.text.trim(), // إزالة المسافات الزائدة
        password: passwordController.text.trim(),
      );

      Either<Failure, LoginModel> result =
          await sl<LoginRepo>().login(loginRequest);

      isLoading.value = false;

      result.fold(
        (failure) {
          Get.snackbar('Error', failure.message,
              backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
        },
        (loginModel) async {
          if (loginModel.token != null && loginModel.user != null) {
            // حفظ بيانات المستخدم
            await sl<StorageService>().saveUserSession(
              token: loginModel.token!,
              userName: loginModel.user!.name ?? '',
              userEmail: loginModel.user!.email ?? '',
              userId: loginModel.user!.id ?? 0,
            );

            Get.snackbar('Success', Strings.loginSuccess,
                backgroundColor: Colors.green,
                snackPosition: SnackPosition.BOTTOM);

            // تفريغ الحقول بعد نجاح تسجيل الدخول
            emailController.clear();
            passwordController.clear();

            // التوجيه للـ HomeView وإزالة جميع الشاشات السابقة
            Get.offAll(() => HomeView());
          } else {
            Get.snackbar('Error', loginModel.message ?? "Login failed",
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.BOTTOM);
          }
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred: $e',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }
}
