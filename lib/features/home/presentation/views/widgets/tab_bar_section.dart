import 'package:bitvest/features/home/presentation/views/widgets/highest_gain_list.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_tab_bar.dart';
import 'biggest_movers_list.dart';
import 'highest_loss_list.dart';

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTabBar(
      tabs: const [
        Tab(text: "Hot Coins"),
        Tab(text: "Top Gainers"),
        Tab(text: "Top Losers"),
      ],
      tabBarViewChildren: const [
        BiggestMoversList(),
        HighestGainList(),
        HighestLossList(),
      ],
    );
  }
}
