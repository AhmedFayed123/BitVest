import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/constant/styles.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/utils/app_session.dart';
import '../../../onboarding/presentation/views/onboarding_screen.dart';
import '../../../onboarding/presentation/views/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _navigateToNextScreen(); // Call the check function

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
              SpinKitFadingCircle(
                color: kAmberColor, // Set the color to gold (amber)
                size: Sizes.buttonHeightMedium, // Set the size of the spinner
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Check onboarding status and navigate accordingly
  void _navigateToNextScreen() async {
    final sessionManager = SessionManager();
    bool isFirstLaunch = await sessionManager.isFirstLaunch();

    Future.delayed(const Duration(seconds: 2), () {
      if (isFirstLaunch) {
        Get.off(() => OnboardingScreen()); // Navigate to onboarding screen
      } else {
        Get.off(() => const WelcomeScreen()); // Navigate to the main screen
      }
    });
  }
}
