import 'package:bitvest/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/components/widgets/custom_button.dart';
import '../../../../generated/assets.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final TextEditingController nameController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),

                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 52.w,
                        backgroundColor: kWhiteColor,
                        child: Obx(() {
                          final imageUrl = controller.profile.value?.profilePicture?.url;
                          final selectedImage = controller.selectedImage.value;

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100.w),
                            child: selectedImage != null
                                ? Image.file(
                              selectedImage,
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                            )
                                : imageUrl != null && imageUrl.isNotEmpty
                                ? Image.network(
                              imageUrl,
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
                                : Image.asset(
                              Assets.imagesProfile,
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                      ),
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: GestureDetector(
                          onTap: controller.pickImage,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: kPrimaryColor,
                            child: const Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return Skeletonizer(
                        enabled: true,
                        child: Column(
                          children: [
                            Container(width: 150, height: 20, color: Colors.white),
                            SizedBox(height: 8.h),
                            Container(width: 200, height: 16, color: Colors.grey),
                          ],
                        ),
                      );
                    } else if (controller.errorMessage.value != null) {
                      return Text(controller.errorMessage.value!,
                          style: const TextStyle(color: Colors.red));
                    } else if (controller.profile.value != null) {
                      nameController.text = controller.profile.value!.name ?? '';
                      return Column(
                        children: [
                          TextField(
                            controller: nameController,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[900],
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor, width: 2),
                              ),
                              hintText: "Enter your name",
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            controller.profile.value!.email ?? '',
                            style: const TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      );
                    } else {
                      return const Text("No data available", style: TextStyle(color: Colors.grey));
                    }
                  }),

                  SizedBox(height: 30.h),

                  Obx(() {
                    return CustomButton(
                      text: controller.isUpdating.value ? "Updating..." : "Save Changes",
                      onPressed: () {
                        controller.updateProfile(nameController.text);
                      },
                      isLoading: controller.isUpdating.value,
                    );
                  }),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
