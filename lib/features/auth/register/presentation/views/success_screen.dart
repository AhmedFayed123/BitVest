// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../core/components/widgets/custom_button.dart';
// import '../../../../../core/constant/colors.dart';
// import '../../../../../core/constant/icons.dart';
// import '../../../../../core/constant/sizes.dart';
// import '../../../../../core/constant/strings.dart';
// import '../../../../../core/constant/styles.dart';
// import '../../../../onboarding/presentation/views/welcome_screen.dart';
//
// class SuccessScreen extends StatelessWidget {
//   const SuccessScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // إخفاء زر الرجوع
//         title: Center(
//           child: Text(
//             Strings.successTitle, // "Success" من ملف strings
//             style: AppStyles.regularTextStyle.copyWith(
//               color: kWhiteColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: Sizes.paddingLarge, vertical: Sizes.paddingMedium),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: Sizes.spaceLarger),
//             Icon(
//               AppIcons.check_circle,
//               size: Sizes.iconLittleLarge,
//               color: kAmberColor,
//             ),
//             SizedBox(height: Sizes.spaceLarge),
//             Text(
//               Strings.registrationSuccess,
//               // "Registration Successful!" من ملف strings
//               style: AppStyles.regularTextStyle.copyWith(
//                 color: kWhiteColor,
//                 fontSize: Sizes.fontSizeExtraLarge,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: Sizes.spaceMedium),
//             Text(
//               Strings.welcomeMessage,
//               // "You have successfully signed up. Welcome!" من ملف strings
//               textAlign: TextAlign.center,
//               style: AppStyles.regularTextStyle.copyWith(
//                 color: kWhiteColor,
//                 fontSize: Sizes.fontSizeMedium,
//               ),
//             ),
//             SizedBox(height: Sizes.spaceLarger),
//             CustomButton(
//               text: Strings.goToWelcome, // زر تسجيل الدخول
//               onPressed: () {
//                 // توجيه المستخدم إلى شاشة تسجيل الدخول
//                 Get.offAll(() => const WelcomeScreen());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
