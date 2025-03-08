import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/widgets/circle_loading.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/services/biometric_auth_service.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../onboarding/presentation/views/onboarding_screen.dart';
import '../../../onboarding/presentation/views/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToNextScreen());

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Images.splashScreenImage,
                width: Sizes.iconSplashLarge,
                height: Sizes.iconSplashLarge,
              ),
              SizedBox(height: Sizes.spaceSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.appLogo,
                    width: Sizes.iconSizeLarge,
                    height: Sizes.iconSizeLarge,
                  ),
                  SizedBox(width: Sizes.spaceSmall),
                  Text(
                    Strings.appName,
                    style: AppStyles.regularTextStyle.copyWith(
                      color: kWhiteColor,
                      fontWeight: FontWeight.w100,
                      fontSize: Sizes.iconSizeLarge,
                    ),
                  ),
                ],
              ),
              SizedBox(height: Sizes.spaceSmall),
              Text(
                Strings.welcomeWord,
                textAlign: TextAlign.center,
                style: AppStyles.regularTextStyle.copyWith(
                  color: kSecondaryTextColor,
                  fontSize: Sizes.kSmallBodyTextSize,
                  letterSpacing: Sizes.spaceSmall,
                ),
              ),
              SizedBox(height: Sizes.cardHeightSmall),
              const CircleLoading(),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen() async {
    final storageService = sl<StorageService>();
    final biometricAuthService = BiometricAuthService();

    bool isFirstLaunch = await storageService.isFirstLaunch();
    bool isLoggedIn = await storageService.isUserLoggedIn();

    await Future.delayed(const Duration(seconds: 2));

    if (isFirstLaunch) {
      Get.offAll(() => OnboardingScreen());
    } else if (isLoggedIn) {
      // bool isAuthenticated = await biometricAuthService.authenticate();
      // if (isAuthenticated) {
        Get.offAll(() => HomeView());
      // } else {
      //   Get.offAll(() => const WelcomeScreen());
      // }
    } else {
      Get.offAll(() => const WelcomeScreen());
    }
  }
}
