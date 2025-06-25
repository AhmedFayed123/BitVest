class FuturesAvailableCoins {
  FuturesAvailableCoins({
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
    this.balance,
  });

  FuturesAvailableCoins.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    icon = json['icon'];
    price = (json['price'] as num?)?.toDouble();
    changeRatePercentage = (json['change_rate_percentage'] as num?)?.toDouble();
    changeRateUsdt = (json['change_rate_usdt'] as num?)?.toDouble();
    volume = (json['volume'] as num?)?.toDouble();
    marketCap = (json['market_cap'] as num?)?.toDouble();
    marketCapRank = (json['market_cap_rank'] as num?)?.toDouble();
    balance = json['balance'];
  }

  String? id;
  String? name;
  String? symbol;
  String? icon;
  double? price;
  double? changeRatePercentage;
  double? changeRateUsdt;
  double? volume;
  double? marketCap;
  double? marketCapRank;
  String? balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['symbol'] = symbol;
    map['icon'] = icon;
    map['price'] = price;
    map['change_rate_percentage'] = changeRatePercentage;
    map['change_rate_usdt'] = changeRateUsdt;
    map['volume'] = volume;
    map['market_cap'] = marketCap;
    map['market_cap_rank'] = marketCapRank;
    map['balance'] = balance;
    return map;
  }
}
