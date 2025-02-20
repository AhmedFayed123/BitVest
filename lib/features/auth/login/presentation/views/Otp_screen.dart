// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
//
// import '../../../../../core/components/widgets/custom_button.dart';
// import '../../../../../core/constant/colors.dart';
// import '../../../../../core/constant/sizes.dart';
// import '../../../../../core/constant/strings.dart';
// import '../controllers/Otp_controller.dart';
//
//
// class OtpScreen extends StatelessWidget {
//   const OtpScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final OtpController controller = Get.put(OtpController());
//
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: kWhiteColor),
//         title: const Text(
//           Strings.otpVerification,
//           style: TextStyle(color: kWhiteColor),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(Sizes.paddingLarge),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 Strings.enterOtpCode,
//                 style: TextStyle(color: kWhiteColor, fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: Sizes.spaceLarge),
//               OtpTextField(
//                 numberOfFields: 6,
//                 borderColor: kBorderColor,
//                 focusedBorderColor: kAmberColor,
//                 textStyle: const TextStyle(color: kWhiteColor),
//                 showFieldAsBox: true,
//                 fieldWidth: 45.0,
//                 onCodeChanged: (String code) {
//                   controller.updateOtp(code);
//                 },
//                 onSubmit: (String verificationCode) {
//                   controller.updateOtp(verificationCode);
//                   controller.verifyOtp();
//                 },
//               ),
//               SizedBox(height: Sizes.spaceLarge),
//               Obx(() => CustomButton(
//                 text: Strings.verify,
//                 onPressed: controller.isLoading.value
//                     ? (){}
//                     : controller.verifyOtp,
//                 isLoading: controller.isLoading.value,
//               )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
