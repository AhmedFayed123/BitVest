import 'package:bitvest/features/trade/presentation/views/widgets/coin_details_view_body.dart';
import 'package:flutter/material.dart';

class CoinDetailsView extends StatelessWidget {
  final String coinId;

  const CoinDetailsView({super.key, required this.coinId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: CoinDetailsViewBody(coinId: coinId)),
    );
  }
}

