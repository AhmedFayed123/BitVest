import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_crypto_list_item.dart';
import '../../../../../core/constant/clases.dart';

class RecommendedList extends StatelessWidget {
  const RecommendedList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 3,
        itemBuilder: (context, index) {
          return CustomCryptoListItem(
            name: "Polygon",
            symbol: "MATIC",
            price: "0.51",
            change: "-0.02",
            percent: "-0.49%",
            isNegative: true,
            chartData: [
              CustomChartData('0', 0.55),
              CustomChartData('1', 0.54),
              CustomChartData('2', 0.53),
              CustomChartData('3', 0.52),
              CustomChartData('4', 0.51),
              CustomChartData('5', 0.50),
              CustomChartData('6', 0.51),
            ], img: '', onTap: () {  },
          );
        },
      ),
    );
  }
}
