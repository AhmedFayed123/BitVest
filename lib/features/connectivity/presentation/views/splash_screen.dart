import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../core/components/widgets/circle_loading.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../onboarding/presentation/views/onboarding_screen.dart';
import '../../../onboarding/presentation/views/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToNextScreen();
    });
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Replace Icon with Image.asset to show your logo
              Image.asset(
                Images.splashScreenImage, // Path to your logo image
                width: Sizes.iconSplashLarge, // Set the width of the logo
                height: Sizes.iconSplashLarge, // Set the height of the logo
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.appLogo, // Path to your logo image
                    width: Sizes.iconSizeLarge, // Set the width of the logo
                    height: Sizes.iconSizeLarge, // Set the height of the logo
                  ),
                  SizedBox(width: Sizes.spaceSmall),
                  Column(
                    children: [
                      Text(
                        Strings.appName,
                        style: AppStyles.regularTextStyle.copyWith(
                          color: kWhiteColor, // Override color for error text
                          fontWeight: FontWeight.w100, // Bold the message
                          fontSize:
                              Sizes.iconSizeLarge, // Use the correct font size
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Sizes.spaceSmall),

              Text(
                Strings.welcomeWord,
                textAlign: TextAlign.center,
                style: AppStyles.regularTextStyle.copyWith(
                  color: kSecondaryTextColor,
                  // Override color for description
                  fontSize: Sizes.kSmallBodyTextSize,
                  // Use the correct font size
                  letterSpacing: Sizes.spaceSmall,
                ),
              ),
              SizedBox(height: Sizes.cardHeightSmall),
              // Replacing CircularProgressIndicator with SpinKit
              CircleLoading(),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen() async {
    // استرجاع حالة أول تشغيل وتسجيل الدخول
    bool isFirstLaunch = await sl<StorageService>().isFirstLaunch();
    bool isLoggedIn = await sl<StorageService>().isUserLoggedIn();

    // تأخير الشاشة لمدة ثانيتين
    await Future.delayed(const Duration(seconds: 2));

    if (isFirstLaunch) {
      Get.offAll(() => OnboardingScreen());// أول مرة يفتح التطبيق -> يروح Onboarding
    } else if (isLoggedIn) {
      Get.offAll(() => HomeView()); // المستخدم مسجل دخول -> يروح Home

    } else {
      Get.offAll(() => const WelcomeScreen()); // مش مسجل دخول -> يروح Welcome
    }
  }

}
