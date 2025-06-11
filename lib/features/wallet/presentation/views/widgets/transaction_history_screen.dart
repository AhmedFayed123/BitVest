import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/wallet_controller.dart';


class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.find<WalletController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: Obx(() {
        if (controller.isTransactionLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.transactionErrorMessage.value != null) {
          return Center(
            child: Text(
              controller.transactionErrorMessage.value!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final transactions = controller.transactionHistory.value?.data ?? [];

        if (transactions.isEmpty) {
          return const Center(child: Text('No transactions found.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: transactions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final tx = transactions[index];
            final isBuy = tx.transactionType?.toLowerCase() == 'buy';

            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                    isBuy ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    child: Icon(
                      isBuy ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      color: isBuy ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${isBuy ? 'Buy' : 'Sell'} ${tx.currency?.toUpperCase()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(tx.createdAt),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${tx.amount} ${tx.currency?.toUpperCase()}',
                        style: TextStyle(
                          color: isBuy ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tx.status?.capitalize ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  String _formatDate(String? rawDate) {
    if (rawDate == null) return '';
    final dateTime = DateTime.tryParse(rawDate);
    if (dateTime == null) return rawDate;
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }
}
