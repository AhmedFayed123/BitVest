import 'package:bitvest/features/wallet/presentation/views/widgets/wallet_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/widgets/custom_tab_bar.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBar(
        tabBarViewHeight: 644,
        tabs: const [
          Tab(text: "Overview"),
          Tab(text: "Spot"),
          Tab(text: "Funding"),
        ],
        tabBarViewChildren: const [
          WalletViewBody(),
          Center(child: Text('Spot'),),
          Center(child: Text('Funding'),),
        ],
      ),
    );
  }
}
