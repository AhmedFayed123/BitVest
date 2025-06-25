class PositionOpenRequest {
  PositionOpenRequest({
      this.currency, 
      this.size, 
      this.leverage, 
      this.price, 
      this.direction,});

  PositionOpenRequest.fromJson(dynamic json) {
    currency = json['currency'];
    size = json['size'];
    leverage = json['leverage'];
    price = json['price'];
    direction = json['direction'];
  }
  String? currency;
  double? size;
  int? leverage;
  int? price;
  String? direction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['size'] = size;
    map['leverage'] = leverage;
    map['price'] = price;
    map['direction'] = direction;
    return map;
  }

}