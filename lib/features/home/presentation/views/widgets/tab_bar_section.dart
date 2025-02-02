import 'package:bitvest/features/home/presentation/views/widgets/recommended_list.dart';
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
        Tab(text: "Biggest movers"),
        Tab(text: "Highest loss"),
        Tab(text: "Recommended"),
      ],
      tabBarViewChildren: const [
        BiggestMoversList(),
        HighestLossList(),
        RecommendedList(),
      ],
    );
  }
}
