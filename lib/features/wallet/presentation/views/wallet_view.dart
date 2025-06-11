import 'package:bitvest/features/wallet/presentation/views/widgets/transaction_history_screen.dart';
import 'package:bitvest/features/wallet/presentation/views/widgets/wallet_view_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/wallet_controller.dart';


class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController controller = Get.find<WalletController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet',),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () async {
              await controller.getTransactionHistory();
              Get.to(() => const TransactionHistoryScreen());
            },
          )
        ],
      ),
      body: WalletViewBody(),
    );
  }
}

// class WalletView extends StatelessWidget {
//   const WalletView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomTabBar(
//         tabBarViewHeight: 644,
//         tabs: const [
//           Tab(text: "Overview"),
//           Tab(text: "Spot"),
//           Tab(text: "Funding"),
//         ],
//         tabBarViewChildren: const [
//           WalletViewBody(),
//           Center(child: Text('Spot',style: TextStyle(color: Colors.white),),),
//           Center(child: Text('Funding',style: TextStyle(color: Colors.white),),),
//         ],
//       ),
//     );
//   }
// }
