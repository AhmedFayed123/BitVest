import 'package:bitvest/features/onboarding/presentation/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/services/storage_service.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            image: Image.asset(Images.onboarding1Image),
            title: Strings.secureTransactionsTitle,
            body: Strings.secureTransactionsBody,
            decoration: PageDecoration(
              imageFlex: Sizes.imageFlex,
              bodyTextStyle: const TextStyle(color: kWhiteColor),
              titleTextStyle:
                  TextStyle(color: kAmberColor, fontSize: Sizes.kHeadingSize),
            ),
          ),
          PageViewModel(
            image: Image.asset(Images.onboarding2Image),
            title: Strings.investSmartlyTitle,
            body: Strings.investSmartlyBody,
            decoration: PageDecoration(
              imageFlex: Sizes.imageFlex,
              bodyTextStyle: const TextStyle(color: kWhiteColor),
              titleTextStyle:
                  TextStyle(color: kAmberColor, fontSize: Sizes.kHeadingSize),
            ),
          ),
          PageViewModel(
            image: Image.asset(Images.onboarding3Image),
            title: Strings.joinRevolutionTitle,
            body: Strings.joinRevolutionBody,
            decoration: PageDecoration(
              imageFlex: Sizes.imageFlex,
              bodyTextStyle: const TextStyle(color: kWhiteColor),
              titleTextStyle:
                  TextStyle(color: kAmberColor, fontSize: Sizes.kHeadingSize),
            ),
          ),
        ],
        onDone: () {
          _completeOnboarding();
        },
        globalBackgroundColor: kBackgroundColor,
        showSkipButton: true,
        skip: const Text(Strings.skipButton,
            style: TextStyle(color: kWhiteColor)),
        next: const Icon(AppIcons.arrow_forward, color: kWhiteColor),
        done: const Text(Strings.getStartedButton,
            style: TextStyle(color: kWhiteColor)),
        dotsDecorator: DotsDecorator(
          color: Colors.white.withOpacity(0.3),
          activeColor: kAmberColor,
          size: Size(Sizes.smallDotsSize, Sizes.smallDotsSize),
          activeSize: Size(Sizes.mediumDotsSize, Sizes.smallDotsSize),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.borderRadiusSimi),
          ),
        ),
      ),
    );
  }

  void _completeOnboarding() async {
    await sl<StorageService>().setFirstLaunch(false);

    Get.off(() => const WelcomeScreen());
  }
}
