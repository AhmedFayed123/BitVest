class PopularCoinsModel {
  List<PopularCoin>? coins;

  PopularCoinsModel({this.coins});

  PopularCoinsModel.fromJson(List<dynamic> jsonList) {
    coins = jsonList.map((json) => PopularCoin.fromJson(json)).toList();
  }

  List<Map<String, dynamic>> toJson() {
    return coins?.map((coin) => coin.toJson()).toList() ?? [];
  }
}

class PopularCoin {
  String? id;
  String? name;
  String? symbol;
  String? icon;
  double? price;
  double? changeRatePercentage;
  double? changeRateUsdt;
  double? volume;
  double? marketCap;
  int? marketCapRank;

  PopularCoin({
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

  PopularCoin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    icon = json['icon'];
    price = (json['price'] as num?)?.toDouble();
    changeRatePercentage = (json['change_rate_percentage'] as num?)?.toDouble();
    changeRateUsdt = (json['change_rate_usdt'] as num?)?.toDouble();
    volume = (json['volume'] as num?)?.toDouble();
    marketCap = (json['market_cap'] as num?)?.toDouble();
    marketCapRank = json['market_cap_rank'];
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
