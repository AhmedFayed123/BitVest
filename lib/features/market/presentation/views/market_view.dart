import 'package:bitvest/features/market/presentation/views/widgets/all_list.dart';
import 'package:bitvest/features/market/presentation/views/widgets/hot_list.dart';
import 'package:bitvest/features/market/presentation/views/widgets/new_list.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/widgets/custom_tab_bar.dart';

class MarketView extends StatelessWidget {
  const MarketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTabBar(
        tabBarViewHeight: 644,
        tabs: const [
          Tab(text: "All"),
          Tab(text: "Hot"),
          Tab(text: "New"),
          Tab(text: "Favorites"),
        ],
        tabBarViewChildren: const [
          AllList(),
          HotList(),
          NewList(),
          Center(child: Text('Favorites', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
