class Data {
  Data({
      this.id, 
      this.walletId, 
      this.transactionType, 
      this.amount, 
      this.currency, 
      this.status, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    walletId = json['wallet_id'];
    transactionType = json['transaction_type'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? walletId;
  String? transactionType;
  String? amount;
  String? currency;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['wallet_id'] = walletId;
    map['transaction_type'] = transactionType;
    map['amount'] = amount;
    map['currency'] = currency;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}