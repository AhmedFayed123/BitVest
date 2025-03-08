import 'package:bitvest/features/wallet/presentation/views/widgets/wallet_view_body.dart';
import 'package:flutter/material.dart';


class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet',),
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
