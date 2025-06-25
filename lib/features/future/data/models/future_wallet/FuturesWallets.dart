class FuturesWallets {
  FuturesWallets({
      this.id, 
      this.userId, 
      this.currency, 
      this.balance, 
      this.margin, 
      this.createdAt, 
      this.updatedAt,});

  FuturesWallets.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    currency = json['currency'];
    balance = json['balance'];
    margin = json['margin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? currency;
  String? balance;
  String? margin;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['currency'] = currency;
    map['balance'] = balance;
    map['margin'] = margin;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}