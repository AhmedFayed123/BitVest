import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to BitVest!",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "By using this application, you agree to be bound by the following terms and conditions:",
                style: TextStyle(fontSize: 14.sp, color: Colors.white70),
              ),
              SizedBox(height: 16.h),
              _buildBulletPoint("You must be at least 18 years old."),
              _buildBulletPoint("Do not use the app for any illegal or unauthorized purpose."),
              _buildBulletPoint("Your use of the app is at your sole risk."),
              _buildBulletPoint("We reserve the right to terminate your account at any time."),
              _buildBulletPoint("All investments carry risk. Past performance is not indicative of future results."),
              SizedBox(height: 20.h),
              Text(
                "Changes to Terms",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "We may update these terms from time to time. Continued use of the app after any changes constitutes your acceptance of the new terms.",
                style: TextStyle(fontSize: 14.sp, color: Colors.white70),
              ),
              SizedBox(height: 20.h),
              Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "If you have any questions or concerns, feel free to contact us at support@bitvest.com.",
                style: TextStyle(fontSize: 14.sp, color: Colors.white70),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 14.sp, color: Colors.white)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14.sp, color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
