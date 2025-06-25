import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    String currentTime = DateFormat('h:mm a').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy - BitVEST',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
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
                  'Updated on $currentDate at $currentTime',
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
              'We value your privacy and are committed to protecting your personal information. This Privacy Policy outlines how BitVEST collects, uses, and protects your data when you use our services.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              '1. Information We Collect:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            const Text(
              'We may collect information such as your name, email address, phone number, and device information when you use our platform.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              '2. How We Use Your Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your data helps us improve our services, process transactions, send updates, and ensure account security.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              '3. Data Security:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            const Text(
              'We implement advanced security measures to protect your personal data from unauthorized access or disclosure.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              '4. Third-Party Services:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            const Text(
              'We do not sell or trade your personal data. However, we may share information with trusted third parties who assist us in operating our services.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              '5. Your Rights:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 10),
            const Text(
              'You have the right to access, modify, or delete your personal data at any time by contacting our support team.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              'If you have any questions or concerns about this policy, please contact us at: support@bitvest.com',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
