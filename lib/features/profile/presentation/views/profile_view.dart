import 'package:bitvest/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/components/widgets/custom_button.dart';
import '../../../../generated/assets.dart';
import '../../../home/presentation/views/widgets/PrivacyPolicyScreen.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 30),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 52.w,
                    backgroundColor: kWhiteColor,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.w),
                        child: Image.network(
                          '',
                          width: 100.w,
                          height: 100.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              Assets.imagesProfile,
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                        //     : Image.asset(
                        //   Assets.imagesProfile,
                        //   width: 140.w,
                        //   height: 140.w,
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                  ),

                  SizedBox(height: 16.h),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return Skeletonizer(
                        enabled: true,
                        child: Column(
                          children: [
                            Container(
                              width: 150,
                              height: 20,
                              color:
                                  Colors.white,
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: 200,
                              height: 16,
                              color:
                                  Colors.grey,
                            ),
                          ],
                        ),
                      );
                    } else if (controller.errorMessage.value != null) {
                      return Text(
                        controller.errorMessage.value!,
                        style: const TextStyle(color: Colors.red),
                      );
                    } else if (controller.profile.value != null) {
                      return Column(
                        children: [
                          Text(
                            controller.profile.value!.name ?? '',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            controller.profile.value!.email ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text(
                        "No data available",
                        style: TextStyle(color: Colors.grey),
                      );
                    }
                  }),
                  SizedBox(height: 30.h),

                  // القائمة
                  _buildProfileOption("Terms Of Service", () {}),
                  _buildProfileOption("Privacy Policy", () {
                    Get.to(() => const PrivacyPolicyScreen());
                  }),
                  _buildProfileOption("Risk and Compliance Disclosures", () {}),

                  SizedBox(height: 10.h),
                  const Divider(color: Colors.grey, height: 1),
                  SizedBox(height: 10.h),

                  _buildProfileOption("Check for Update", () {}),
                  _buildProfileOption("Clear Cache", () {}),

                  SizedBox(height: 30.h),

                  // زر تسجيل الخروج
                  CustomButton(
                    text: 'Log Out',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}
