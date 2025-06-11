import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/p2p_controller.dart';

class MyAdsScreen extends StatelessWidget {
  MyAdsScreen({super.key});

  // متغيرات Rx للتحكم في اظهار المزيد لكل قائمة
  final RxBool showAllBuy = false.obs;
  final RxBool showAllSell = false.obs;

  @override
  Widget build(BuildContext context) {
    final P2pController controller = Get.find<P2pController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ads'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.userBuyAds.isEmpty && controller.userSellAds.isEmpty) {
          return const Center(
            child: Text(
              'No ads available.',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Buy Ads'),
              const SizedBox(height: 12),

              // قائمة Buy Ads مع التحكم في عرض 4 أو الكل
              AdsList(
                ads: showAllBuy.value
                    ? controller.userBuyAds
                    : controller.userBuyAds.take(4).toList(),
              ),

              // زر Show More / Show Less لقائمة Buy Ads
              if (controller.userBuyAds.length > 4)
                TextButton(
                  onPressed: () {
                    showAllBuy.value = !showAllBuy.value;
                  },
                  child: Text(
                    showAllBuy.value ? 'Show Less' : 'Show More',
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ),

              const SizedBox(height: 40),

              const SectionTitle(title: 'Sell Ads'),
              const SizedBox(height: 12),

              // قائمة Sell Ads مع التحكم في عرض 4 أو الكل
              AdsList(
                ads: showAllSell.value
                    ? controller.userSellAds
                    : controller.userSellAds.take(4).toList(),
              ),

              // زر Show More / Show Less لقائمة Sell Ads
              if (controller.userSellAds.length > 4)
                TextButton(
                  onPressed: () {
                    showAllSell.value = !showAllSell.value;
                  },
                  child: Text(
                    showAllSell.value ? 'Show Less' : 'Show More',
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

// باقي الكود كما هو:
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.1,
      ),
    );
  }
}

class AdsList extends StatelessWidget {
  final List ads;
  const AdsList({required this.ads, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ads.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final ad = ads[index];
        return Card(
          color: Colors.grey[850],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          shadowColor: Colors.blueAccent.withOpacity(0.3),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            title: Text(
              '${ad.currency} - ${ad.amount}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
            ),
            subtitle: Text(
              'Price: ${ad.fiatAmount} ${ad.fiatCurrency}\nPayment: ${ad.paymentMethod}',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor(ad.transferStatus),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                ad.transferStatus ?? '',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blueAccent;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}
