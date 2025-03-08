class Data {
  Data({
      this.id, 
      this.userId, 
      this.currency, 
      this.balance, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    currency = json['currency'];
    balance = json['balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  String? currency;
  String? balance;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['currency'] = currency;
    map['balance'] = balance;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}