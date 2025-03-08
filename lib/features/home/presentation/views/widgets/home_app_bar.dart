import 'package:bitvest/features/home/presentation/views/widgets/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/icons.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../../../../../core/constant/styles.dart';
import '../../../../../core/resources/images.dart';
import '../../../../account_verification/presentation/views/gender_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: kButtonShadow,
      ),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(right: 12.0.w),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                AppIcons.drawer,
                color: kWhiteColor,
              ),
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();

              },
            ),
            SizedBox(width: 5.w,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Images.appLogo, // Path to your logo image
                  width: Sizes.kSubHeadingSize.w, // Set the width of the logo
                  height: Sizes.kSubHeadingSize.h, // Set the height of the logo
                ),
                Text(
                  Strings.appName,
                  style: AppStyles.regularTextStyle.copyWith(
                    color: kWhiteColor, // Override color for error text
                    fontWeight: FontWeight.w600, // Bold the message
                    fontSize:
                    Sizes.kSubHeadingSize, // Use the correct font size
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              icon: const Icon(
                AppIcons.search,
                color: kWhiteColor,
              ),
              onPressed: () {
                Get.to(SearchScreen());
              },
            ),
            IconButton(
              icon: const Icon(
                AppIcons.qrCode,
                color: kWhiteColor,
              ),
              onPressed: () {Get.to(GenderScreen(),);},
            ),
            IconButton(
              icon: const Icon(
                AppIcons.notifications_active,
                color: kWhiteColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
