import 'package:bitvest/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/trade_controller.dart';

class BuyScreen extends StatefulWidget {
  final String cryptoName;
  final String cryptoId;
  final double marketPrice;

  const BuyScreen({
    Key? key,
    required this.cryptoName,
    required this.cryptoId,
    required this.marketPrice,
  }) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final TradeController tradeController = Get.put(TradeController());

  String selectedOrderType = 'Market Order';
  double amount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, size: 30),
          onPressed: () => Get.back(),
        ),
        title: Text('Buy ${widget.cryptoName}', style: const TextStyle(fontSize: 22)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.cryptoName} / USDT',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                Text(
                  'Market Price\n\$${widget.marketPrice.toStringAsFixed(2)}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('${widget.cryptoId} / USDT',
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),

            // اختيار نوع الطلب
            DropdownButton<String>(
              value: selectedOrderType,
              items: ['Market Order', 'Limit Order']
                  .map((order) => DropdownMenuItem(
                value: order,
                child: Text(order, style: const TextStyle(color: Colors.green)),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedOrderType = value!);
              },
              isExpanded: true,
            ),
            const SizedBox(height: 25),

            // إدخال الكمية
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: kWhiteColor,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00 ${widget.cryptoId}',
                  hintStyle: const TextStyle(fontSize: 36, color: Colors.grey),
                ),
                onChanged: (value) {
                  setState(() => amount = double.tryParse(value) ?? 0.0);
                },
              ),
            ),
            const SizedBox(height: 10),

            // عرض المبلغ الإجمالي بالدولار
            Text(
              'Total: \$${(amount * widget.marketPrice).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // زر تأكيد الشراء
            ElevatedButton(
              onPressed: amount > 0
                  ? () {
                tradeController.buyCrypto(widget.cryptoId, amount);
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Center(
                child: Text(
                  'Confirm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
