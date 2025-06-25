import 'package:bitvest/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/get_ads_model/Data.dart';
import '../../controller/p2p_controller.dart';
import 'trade_details_screen.dart';

class P2pTraderCard extends StatelessWidget {
  final AdsData trader;

  const P2pTraderCard({super.key, required this.trader});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<P2pController>();

    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and name
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: kPositiveTrendColor,
                  child: Icon(Icons.person, color: Colors.black),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    trader.user?.name ?? 'Unknown',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    trader.currency ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _detail("Amount",
                "${trader.amount ?? ''} ${trader.currency ?? ''}"),
            const SizedBox(height: 6),
            _detail("Price",
                "${trader.fiatAmount ?? ''} ${trader.fiatCurrency ?? ''}"),

            const SizedBox(height: 6),

            _detail("Payment", trader.paymentMethod ?? ''),

            const SizedBox(height: 16),

            // Action Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isBuying.value
                          ? kPositiveTrendColor
                          : kNegativeTrendColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.to(
                        () => TradeDetailsScreen(
                          id: trader.id ?? 0,
                          price: trader.fiatAmount ?? '',
                          paymentMethod: trader.paymentMethod ?? '',
                          traderName: trader.user?.name ?? '',
                          limit: trader.amount ?? '',
                          currency: trader.currency ?? '',
                          paymentDetails: trader.paymentDetails ?? '',
                        ),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Text(
                      controller.isBuying.value ? 'Buy Now' : 'Sell Now',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _detail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text.rich(
        TextSpan(
          text: '$label: ',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
