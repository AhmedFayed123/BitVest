// import 'package:bitvest/core/constant/colors.dart';
// import 'package:bitvest/core/constant/icons.dart';
// import 'package:bitvest/core/settings/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/components/widgets/custom_button.dart';
// import '../../../../core/constant/strings.dart';
// import '../controllers/swap_controller.dart';
//
// class SwapView extends StatelessWidget {
//   IconData _getCurrencyIcon(String currency) {
//     switch (currency) {
//       case "BTC":
//         return Icons.currency_bitcoin;
//       case "ETH":
//         return Icons.attach_money;
//       case "USDT":
//         return Icons.attach_money;
//       case "BNB":
//         return Icons.monetization_on;
//       default:
//         return Icons.help_outline;
//     }
//   }
//
//   final SwapController controller = Get.put(SwapController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Swap'),
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(AppIcons.back_arrow, color: kPrimaryTextColor),
//             onPressed: () {Get.back();},
//           ),
//         ),
//         body: Padding(
//           padding:  EdgeInsets.all(16.0.sp),
//           child: Column(
//             children: [
//               Obx(() => _buildSwapContainer(
//                     title: "You send",
//                     currency: controller.sendCurrency.value,
//                     balance: controller.sendBalance.value.toStringAsFixed(8),
//                     amount: controller.sendAmount,
//                     onCurrencyChanged: (newValue) {
//                       controller.sendCurrency.value = newValue!;
//                     },
//                   )),
//               SizedBox(height: 1),
//               IconButton(
//                 icon: Icon(Icons.swap_vert, color: kPrimaryTextColor, size: 22.h),
//                 onPressed: controller.swapCurrencies,
//               ),
//               SizedBox(height: 1),
//               Obx(() => _buildSwapContainer(
//                     title: "You get",
//                     currency: controller.receiveCurrency.value,
//                     balance: controller.receiveBalance.value.toStringAsFixed(8),
//                     amount: controller.receiveAmount,
//                     onCurrencyChanged: (newValue) {
//                       controller.receiveCurrency.value = newValue!;
//                     },
//                   )),
//               SizedBox(height: 35.h),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         " Rate",
//                         style: TextStyle(color: kGreyColor, fontSize: 12.sp),
//                       ),
//                       Text(
//                         "1BTC = 15.40ETH ",
//                         style: TextStyle(color: kPrimaryTextColor, fontSize: 12.sp),
//                       ),
//                     ],
//                   ),
//                   Divider(color: Colors.white38),
//                   SizedBox(height: 8.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         " Price impact",
//                         style: TextStyle(color: kGreyColor, fontSize: 12.sp),
//                       ),
//                       Text(
//                         " 0.02%",
//                         style: TextStyle(color: kChartPositiveColor, fontSize: 12.sp),
//                       ),
//                     ],
//                   ),
//                   Divider(color: kPrimaryTextColor),
//                   SizedBox(height: 8.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         " Liquidity Provider fee",
//                         style: TextStyle(color: kGreyColor, fontSize: 12.sp),
//                       ),
//                       Text(
//                         " 2.5 usd",
//                         style: TextStyle(color: kPrimaryTextColor, fontSize: 12.sp),
//                       ),
//                     ],
//                   ),
//                   Divider(color: kPrimaryTextColor),
//                 ],
//               ),
//               SizedBox(height: 18.h,),
//               CustomButton(text: Strings.confirm, onPressed: () {}),
//             ],
//           ),
//         ));
//   }
//
//   Widget _buildSwapContainer({
//     required String title,
//     required String currency,
//     required String balance,
//     required RxDouble amount,
//     required Function(String?) onCurrencyChanged,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16.sp),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(color: Colors.white70, fontSize: 14),
//           ),
//           SizedBox(height: 8.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               DropdownButton<String>(
//                 value: currency,
//                 dropdownColor: Colors.grey[900],
//                 icon: Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.white,
//                   size: 30.sp,
//                 ),
//                 items: controller.currencies.map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Row(
//                       children: [
//                         Icon(
//                           _getCurrencyIcon(value),
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: 8.w),
//                         Text(
//                           value,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: onCurrencyChanged,
//               ),
//               SizedBox(width: 16.w),
//               Expanded(
//                 child: TextField(
//                   onChanged: (value) {
//                     amount.value = double.tryParse(value) ?? 0.0;
//                   },
//                   keyboardType: TextInputType.number,
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                   decoration: InputDecoration(
//                     hintText: "Enter amount",
//                     hintStyle: TextStyle(color: Colors.white38),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           Text(
//             "Balance: $balance",
//             style: TextStyle(color: Colors.white38, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }
