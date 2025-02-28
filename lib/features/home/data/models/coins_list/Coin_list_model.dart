class CoinsListModel {
  final List<CoinModel> coins;

  CoinsListModel({required this.coins});

  factory CoinsListModel.fromJson(Map<String, dynamic> jsonMap) {
    return CoinsListModel(
      coins: jsonMap.values.map((e) => CoinModel.fromJson(e)).toList(),
    );
  }
}

class CoinModel {
  final String id;
  final String name;
  final String symbol;
  final String icon;
  final double price;
  final double changeRatePercentage;
  final double changeRateUsdt;
  final double volume;
  final double marketCap;
  final int marketCapRank;

  CoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.icon,
    required this.price,
    required this.changeRatePercentage,
    required this.changeRateUsdt,
    required this.volume,
    required this.marketCap,
    required this.marketCapRank,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      icon: json['icon'],
      price: (json['price'] as num).toDouble(),
      changeRatePercentage: (json['change_rate_percentage'] as num).toDouble(),
      changeRateUsdt: (json['change_rate_usdt'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toDouble(),
      marketCapRank: json['market_cap_rank'],
    );
  }
}
