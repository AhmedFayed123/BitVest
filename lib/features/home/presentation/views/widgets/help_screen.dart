import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Welcome to BitVest!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'BitVest helps you buy, sell, and manage your crypto assets with ease and security.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const Divider(height: 30, color: Colors.grey),
            const Text(
              'How to Use:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            _buildBullet('Sign in using your email or Google account.'),
            _buildBullet('Buy and sell cryptocurrencies in the P2P section.'),
            _buildBullet('Check your balance and transaction history.'),
            _buildBullet('Switch between English and Arabic languages.'),
            const Divider(height: 30, color: Colors.grey),
            const Text(
              'Need Help?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white),
              title: const Text('Email Us', style: TextStyle(color: Colors.white)),
              subtitle: const Text('support@bitvest.com', style: TextStyle(color: Colors.white70)),
              onTap: () {
                // open email intent
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat, color: Colors.white),
              title: const Text('WhatsApp Support', style: TextStyle(color: Colors.white)),
              subtitle: const Text('+2010xxxxxxx', style: TextStyle(color: Colors.white70)),
              onTap: () {
                // open WhatsApp
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Text('• ', style: TextStyle(color: Colors.white, fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
