class CoinModel {
  String? id;
  String? name;
  String? symbol;
  String? icon;
  double? price;
  double? changeRatePercentage;
  double? changeRateUsdt;

  CoinModel({
    this.id,
    this.name,
    this.symbol,
    this.icon,
    this.price,
    this.changeRatePercentage,
    this.changeRateUsdt,
  });

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      icon: json['icon'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      changeRatePercentage: (json['change_rate_percentage'] as num?)?.toDouble(),
      changeRateUsdt: (json['change_rate_usdt'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'icon': icon,
      'price': price,
      'change_rate_percentage': changeRatePercentage,
      'change_rate_usdt': changeRateUsdt,
    };
  }
}

class MarketModel {
  List<CoinModel> coins;

  MarketModel({required this.coins});

  factory MarketModel.fromJson(List<dynamic> jsonList) {
    return MarketModel(
      coins: jsonList.map((e) => CoinModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
