import 'package:bitvest/core/components/widgets/custom_button.dart';
import 'package:bitvest/core/constant/colors.dart';
import 'package:bitvest/core/constant/styles.dart';
import 'package:bitvest/features/account_verification/presentation/views/photo_id_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/sizes.dart';
import '../../../../core/constant/strings.dart';
import '../controller/verification_controller.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VerificationController controller = Get.put(VerificationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is your gender?',
              style: AppStyles.headingStyle2,
            ),
            SizedBox(height: 10.h),
            Obx(() => Column(
                  children: [
                    RadioListTile(
                      title: Text("I am male",
                          style: AppStyles.textStyle14w500,
                      ),
                      value: "male",
                      groupValue: controller.selectedGender.value,
                      activeColor: Colors.yellow,
                      onChanged: (value) {
                        controller.selectGender(value!);
                      },
                    ),
                    RadioListTile(
                      title: Text("I am female",
                        style: AppStyles.textStyle14w500,
                      ),
                      value: "female",
                      groupValue: controller.selectedGender.value,
                      activeColor: Colors.yellow,
                      onChanged: (value) {
                        controller.selectGender(value!);
                      },
                    ),
                  ],
                )),

            Spacer(),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(() => Checkbox(
                  value: controller.isChecked.value,
                  onChanged: (bool? value) {
                    controller.isChecked.value = value ?? false;
                  },
                )),
                Expanded(
                  child: Text(
                    'This information is used for identity verification only, and will be kept secure by CrypCoin',
                    style: TextStyle(color: kWhiteColor, fontSize: Sizes.kFontSizeSmall),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Obx(() => CustomButton(
                  text: Strings.next,
                  onPressed: controller.selectedGender.value.isNotEmpty
                      ? () {
                          Get.snackbar("Success",
                              "Gender selected: ${controller.selectedGender.value}");
                        }
                      : (){
                    Get.to(PhotoIdCardScreen());
                  },
                )),
          ],
        ),
      ),
    );
  }
}
