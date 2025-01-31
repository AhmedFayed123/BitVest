import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/custom_button.dart';
import '../../../../generated/assets.dart';
import '../../../home/presentation/views/widgets/PrivacyPolicyScreen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
              padding:  EdgeInsets.symmetric(horizontal: 16.0.w,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(Assets.imagesElbaba),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ibrahim Ammar',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'ibrahim@gmail.com',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  _buildInputField("Termes Of Service ", () {}),
                  _buildInputField("Privacy Policy", () {
                    Get.to(PrivacyPolicyScreen());
                  }),
                  _buildInputField("Risk and compliance disclosures", () {}),
                  const SizedBox(height: 10),

                  const Divider(color: Colors.grey, height: 1),
                  const SizedBox(height: 10),

                  _buildInputField("Check for update", () {
                  }),
                  _buildInputField("Cleare cache", () {
                  }),
                  const SizedBox(height: 20),
                  CustomButton(text: 'Log Out', onPressed: () {  },),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, VoidCallback onArrowPressed) {
    return Padding(
      padding:  EdgeInsets.symmetric( vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.grey),
            onPressed: onArrowPressed,
          ),
        ],
      ),
    );
  }
}
