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
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// التاجر
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: kPositiveTrendColor,
                  child: Icon(Icons.person, color: Colors.black),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trader.user?.name ?? 'Unknown',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'User ID: ${trader.userId ?? 'N/A'}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildInfoRow('Ad ID', '${trader.id ?? 'N/A'}'),
            _buildInfoRow('Trade Type', trader.tradeType ?? 'N/A'),
            _buildInfoRow('Currency', trader.currency ?? 'N/A'),
            _buildInfoRow('Amount', trader.amount ?? 'N/A'),
            _buildInfoRow('Fiat Amount', trader.fiatAmount ?? 'N/A'),
            _buildInfoRow('Fiat Currency', trader.fiatCurrency ?? 'N/A'),
            _buildInfoRow('Payment Method', trader.paymentMethod ?? 'N/A'),
            _buildInfoRow('Transfer Status', trader.transferStatus ?? 'N/A'),
            _buildInfoRow('Created At', trader.createdAt?.split('T').first ?? 'N/A'),
            _buildInfoRow('Updated At', trader.updatedAt?.split('T').first ?? 'N/A'),
            _buildInfoRow('Counterparty ID', '${trader.counterpartyId ?? 'N/A'}'),

            const SizedBox(height: 16),

            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isBuying.value
                      ? kPositiveTrendColor
                      : kNegativeTrendColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Get.to(
                        () => TradeDetailsScreen(id: trader.id??0, price: trader.fiatAmount??'', paymentMethod: trader.paymentMethod??'', traderName: trader.user!.name??'', limit: trader.amount??'', currency: trader.currency??'',),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Text(
                  controller.isBuying.value ? 'Buy' : 'Sell',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
