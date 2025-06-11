import 'package:bitvest/features/home/presentation/views/widgets/highest_gain_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/custom_tab_bar.dart';
import 'biggest_movers_list.dart';
import 'highest_loss_list.dart';

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTabBar(
      tabs: [
        Tab(text: "Hot Coins".tr),
        Tab(text: "Top Gainers".tr),
        Tab(text: "Top Losers".tr),
      ],
      tabBarViewChildren: const [
        BiggestMoversList(),
        HighestGainList(),
        HighestLossList(),
      ],
    );
  }
}
