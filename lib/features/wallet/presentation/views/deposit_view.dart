import 'package:bitvest/core/components/widgets/circle_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/custom_button.dart';
import '../../../../core/components/widgets/custom_text_form_field.dart';
import '../../../../core/constant/colors.dart';
import '../../../../core/constant/icons.dart';
import '../../../../core/constant/strings.dart';
import '../controllers/deposit_controller.dart';

class DepositView extends StatelessWidget {
  final DepositController controller = Get.put(DepositController());

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposit'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(AppIcons.back_arrow, color: kPrimaryTextColor),
          onPressed: () { Get.back(); },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: Strings.amount, // Assuming 'Strings.amount' is the English string
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.h),
            Obx(() {
              return controller.isLoading.value
                  ? CircleLoading()
                  : CustomButton(
                text: "Start Deposit", // Changed to English
                onPressed: () {
                  final amount = double.tryParse(amountController.text);
                  if (amount != null) {
                    controller.startDeposit(amount);
                  } else {
                    Get.snackbar('Alert', 'Please enter a valid amount'); // Changed to English
                  }
                },
                isLoading: controller.isLoading.value,
              );
            }),
          ],
        ),
      ),
    );
  }
}
