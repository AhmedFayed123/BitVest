import 'package:flutter/material.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/constant/styles.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetScreen(
      {super.key, required this.onRetry}); // Make sure to add this parameter

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.kNoInternetTitle,
            style: AppStyles.headingStyle
                .copyWith(color: kWhiteColor), // Use headingStyle from AppStyles
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: Sizes.kHorizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    AppIcons.kNoInternetIcon,
                    color: kErrorTextColor,
                    size: Sizes.kIconSizeLarge,
                  ),
                  SizedBox(height: Sizes.kVerticalSpacing),
                  Text(
                    Strings.kNoInternetMessage,
                    style: AppStyles.regularTextStyle.copyWith(
                      color: kErrorTextColor, // Override color for error text
                      fontWeight: FontWeight.bold, // Bold the message
                      fontSize: Sizes.kSubHeadingSize, // Use the correct font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Sizes.kVerticalSpacing),
                  Text(
                    Strings.kNoInternetDescription,
                    textAlign: TextAlign.center,
                    style: AppStyles.regularTextStyle.copyWith(
                      color: kSecondaryTextColor, // Override color for description
                      fontSize: Sizes.kBodyTextSize, // Use the correct font size
                    ),
                  ),
                  SizedBox(height: Sizes.kButtonSpacing),
                  ElevatedButton(
                    onPressed: onRetry,
                    // Use the onRetry function passed to the constructor
                    style: ElevatedButton.styleFrom(
                      foregroundColor: kButtonTextColor,
                      backgroundColor: kButtonPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Sizes.kBorderRadius),
                      ),
                    ),
                    child: Text(
                      Strings.kRetryButtonText,
                      style: AppStyles
                          .textStyle14w500, // Use buttonTextStyle from AppStyles
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
