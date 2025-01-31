import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // استخدمنا مكتبة intl للحصول على التاريخ الحالي بصيغة معينة

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    DateFormat('MMMM dd, yyyy').format(DateTime.now());
    String currentTime = DateFormat('h:mm a').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '      Privacy Policy BitVEST',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white,size: 30,),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Update on $currentDate at $currentTime',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const Icon(
                    Icons.access_time_filled_rounded,
                    color: Colors.white70,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Thank you for visiting vaultex.com. The relevant vaultex entity as a the data controller, provides this Privacy Policy Statement to describe our practices regarding the collection, storage, use, disclosure and other processing of Personal Data (defined below). By visiting, accessing, or using vaultex.com and associated application program interfaces or mobile application program interfaces or mobile application program interfaces or mobile applications (the "vaultex platform"), you (a) acknowledge that you have the right, capacity and authority to accept this Privacy Policy Statement (the "Privacy Policy");(b) acknowledge that you have read and understand this Privacy Policy and (c) consent to the policies and practices outlined in this Privacy Policy. So please read them carefully to understand what we do.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
