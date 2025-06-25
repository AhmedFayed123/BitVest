class Data {
  Data({
    this.currency,
    this.amount,
    this.price,
    this.totalCost,
  });

  String? currency;
  double? amount;
  double? price;
  double? totalCost;

  Data.fromJson(dynamic json) {
    currency = json['currency'];
    amount = (json['amount'] as num?)?.toDouble();
    price = (json['price'] as num?)?.toDouble();
    totalCost = (json['total_cost'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['amount'] = amount;
    map['price'] = price;
    map['total_cost'] = totalCost;
    return map;
  }
}
