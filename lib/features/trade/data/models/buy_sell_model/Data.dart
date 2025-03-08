class Data {
  Data({
      this.currency, 
      this.amount, 
      this.price, 
      this.totalCost,});

  Data.fromJson(dynamic json) {
    currency = json['currency'];
    amount = json['amount'];
    price = json['price'];
    totalCost = json['total_cost'];
  }
  String? currency;
  int? amount;
  double? price;
  double? totalCost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['amount'] = amount;
    map['price'] = price;
    map['total_cost'] = totalCost;
    return map;
  }

}