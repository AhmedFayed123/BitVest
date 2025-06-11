import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../../../../../core/constant/strings.dart';
import '../controller/sign_up_controller.dart';

class TermsCheckbox extends StatelessWidget {
  const TermsCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find();

    return Row(
      children: [
        Obx(() => Checkbox(
          value: controller.isChecked.value,
          onChanged: (bool? value) {
            controller.isChecked.value = value ?? false;
          },
        )),
        Expanded(
          child: Text(
            Strings.acceptTerms.tr,
            style: TextStyle(color: kWhiteColor, fontSize: Sizes.kFontSizeSmall),
          ),
        ),
      ],
    );
  }
}