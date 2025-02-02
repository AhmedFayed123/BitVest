import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/custom_crypto_list_item.dart';
import '../../../../../core/constant/clases.dart';

class MyAssetsList extends StatelessWidget {
  const MyAssetsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 15,
        itemBuilder: (context, index) {
          return CustomCryptoListItem(
            name: "Polygon",
            symbol: "MATIC",
            price: "0.51",
            change: "-0.02",
            percent: "-0.49%",
            isNegative: true,
            chartData: [
              ChartData('0', 0.55),
              ChartData('1', 0.54),
              ChartData('2', 0.53),
              ChartData('3', 0.52),
              ChartData('4', 0.51),
              ChartData('5', 0.50),
              ChartData('6', 0.51),
            ],
          );
        },
      ),
    );

  }
}
