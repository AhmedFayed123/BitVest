// File: lib/constants/styles.dart

import 'package:bitvest/core/constant/sizes.dart';
import 'package:bitvest/core/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppStyles {
  // Standard TextStyle for headings
  static TextStyle headingStyle = TextStyle(
    fontSize: Sizes.kHeadingSize.sp,
    fontWeight: FontWeight.bold,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kBlackColor, // Default color
  );
  static TextStyle headingStyle2 = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kWhiteColor, // Default color
  );

  // Standard TextStyle for regular text
  static TextStyle regularTextStyle = TextStyle(
    fontSize: Sizes.kBodyTextSize.sp,
    fontWeight: FontWeight.normal,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: Colors.black87, // Slightly faded black for normal text
  );
  static TextStyle textStyle19regular = TextStyle(
    fontSize: 19.sp,
    fontWeight: FontWeight.w500,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kHintTextColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle24regular = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kHeadingTextColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle18regular = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kPositiveTrendColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle18semiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kPrimaryTextColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle14semiBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kPrimaryTextColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle12regular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kPrimaryTextColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle20regular = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kPrimaryTextColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle14regular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kHintTextColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle16regular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kPrimaryTextColor, // Slightly faded black for normal text
  );
  static TextStyle textStyle16bold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kPrimaryTextColor, // Slightly faded black for normal text
  );

  // Standard TextStyle for captions or smaller text
  static TextStyle captionStyle = TextStyle(
    fontSize: Sizes.captionFontSize.sp,
    fontWeight: FontWeight.w400,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: Colors.grey, // Lighter grey for captions
  );

  // Style for button text
  static TextStyle textStyle14w500 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kPrimaryTextColor, // White text for buttons
  );

  // Style for splash screen text
  static TextStyle splashTextStyle = TextStyle(
    fontSize: Sizes.kHeadingSize.sp,
    fontWeight: FontWeight.bold,
    fontFamily: Strings.kPoppins, // Font family applied here
    color: kBlackColor,
  );
}
