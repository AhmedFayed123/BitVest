class CoinsOfTheUser {
  CoinsOfTheUser({
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
      this.balance,});

  CoinsOfTheUser.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    icon = json['icon'];

    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : json['price'];

    changeRatePercentage = (json['change_rate_percentage'] is int)
        ? (json['change_rate_percentage'] as int).toDouble()
        : json['change_rate_percentage'];

    changeRateUsdt = (json['change_rate_usdt'] is int)
        ? (json['change_rate_usdt'] as int).toDouble()
        : json['change_rate_usdt'];

    volume = json['volume'];
    marketCap = json['market_cap'];
    marketCapRank = json['market_cap_rank'];
    balance = json['balance'].toString();
  }
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