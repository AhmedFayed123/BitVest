import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletAssetItem extends StatelessWidget {
  final String name;
  final String symbol;
  final double price;
  final double changeRateUsdt;
  final double changeRatePercentage;
  final String balance;
  final String icon;
  final bool isNegative;
  final VoidCallback onTap;

  const WalletAssetItem({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.changeRateUsdt,
    required this.changeRatePercentage,
    required this.balance,
    required this.icon,
    required this.isNegative,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[900],
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(icon),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          "$name ($symbol)",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price: \$${price.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white70)),
            Text("Balance: $balance", style: const TextStyle(color: Colors.white70)),
            Text("Change: ${changeRateUsdt.toStringAsFixed(2)} USDT (${changeRatePercentage.toStringAsFixed(2)}%)",
                style: TextStyle(color: isNegative ? Colors.red : Colors.green)),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      ),
    );
  }
}
