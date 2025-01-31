import 'package:bitvest/features/home/presentation/views/widgets/recommended_list.dart';
import 'package:flutter/material.dart';
import 'biggest_movers_list.dart';
import 'highest_loss_list.dart';

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: "Biggest movers"),
              Tab(text: "Highest loss"),
              Tab(text: "Recommended"),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 320,
            child: TabBarView(
              children: [
                BiggestMoversList(),
                HighestLossList(),
                RecommendedList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
