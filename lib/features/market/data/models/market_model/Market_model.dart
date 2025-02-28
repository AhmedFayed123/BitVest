class CoinModel {
  String? id;
  String? name;
  String? symbol;
  String? icon;
  double? price;
  double? changeRatePercentage;
  double? changeRateUsdt;
  int? volume;
  int? marketCap;
  int? marketCapRank;

  CoinModel({
    this.id,
    this.name,
    this.symbol,
    this.icon,
    this.price,
    this.changeRatePercentage,
    this.changeRateUsdt,
    this.volume,
    this.marketCap,
    this.marketCapRank,
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
      volume: (json['volume'] as num?)?.toInt(),
      marketCap: (json['market_cap'] as num?)?.toInt(),
      marketCapRank: (json['market_cap_rank'] as num?)?.toInt(),
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
      'volume': volume,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
    };
  }
}

class MarketModel {
  List<CoinModel> coins;

  MarketModel({required this.coins});

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
      coins: json.values
          .map((e) => CoinModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AllMarketModel {
  List<CoinModel> coins;

  AllMarketModel({required this.coins});

  factory AllMarketModel.fromJson(List<dynamic> jsonList) {
    return AllMarketModel(
      coins: jsonList.map((e) => CoinModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}