class FavouriteCurrency {
  FavouriteCurrency({
      this.userId, 
      this.currency, 
      this.updatedAt, 
      this.createdAt, 
      this.id,});

  FavouriteCurrency.fromJson(dynamic json) {
    userId = json['user_id'];
    currency = json['currency'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  int? userId;
  String? currency;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['currency'] = currency;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

}