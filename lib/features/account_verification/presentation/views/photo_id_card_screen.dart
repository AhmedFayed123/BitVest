import 'dart:io';

import 'package:bitvest/core/constant/icons.dart';
import 'package:bitvest/core/settings/theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/camera_overlay.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/strings.dart';
import '../../../../core/constant/styles.dart';
import '../controller/verification_controller.dart';

class PhotoIdCardScreen extends StatelessWidget {
  const PhotoIdCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VerificationController cameraControllerX = Get.put(VerificationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Photo ID Card',
              style: AppStyles.headingStyle2,
            ),
            SizedBox(height: 12.h,),
            Text(
              'Take a photo of the back side of your document',
              style: AppStyles.textStyle14regular.copyWith(color: kGreyColor),
            ),
            SizedBox(height: 24.h),

            Center(
              child: Obx(() {
                if (cameraControllerX.isLoading.value) {
                  return SpinKitFadingCircle(
                    color: kAmberColor, // Set the color to gold (amber)
                    size: Sizes.buttonHeightMedium, // Set the size of the spinner
                  );
                } else if (cameraControllerX.imagePath.isNotEmpty) {
                  return Image.file(File(cameraControllerX.imagePath.value),
                      width: 310.w, height: 291.h);
                } else {
                  return Stack(
                    children: [
                      Positioned(
                        bottom: 22,
                        right: 50,
                        child: SizedBox(
                          width: 250.w,
                          height: 250.h,
                          child: CameraPreview(cameraControllerX.cameraController!),
                        ),
                      ),
                      Center(
                        child: CameraOverlay(
                          scanAreaWidth: 310.w,
                          scanAreaHeight: 291.h,
                          cornerLength: 20,
                          cornerThickness: 2,
                          cornerColor: kPositiveTrendColor,
                          cornerRadius: 58,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(AppIcons.refresh,color: kWhiteColor,size: 32.sp,),
                  onTap: () => cameraControllerX.initializeCamera(),
                ),
                GestureDetector(
                  onTap: () => cameraControllerX.capturePhoto(),
                  child: Container(
                    width: 85.w,
                    height: 85.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000.r),
                      color: kWhiteColor,
                      border: Border.all(color: kButtonPrimaryColor, width: 5.w),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Text(Strings.next,style: AppStyles.textStyle18semiBold,),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
