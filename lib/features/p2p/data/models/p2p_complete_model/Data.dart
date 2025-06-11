class Data {
  Data({
      this.id, 
      this.userId, 
      this.counterpartyId, 
      this.tradeType, 
      this.currency, 
      this.amount, 
      this.fiatAmount, 
      this.takenAmount, 
      this.startedAt, 
      this.fiatCurrency, 
      this.paymentMethod, 
      this.transferStatus, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    counterpartyId = json['counterparty_id'];
    tradeType = json['trade_type'];
    currency = json['currency'];
    amount = json['amount'];
    fiatAmount = json['fiat_amount'];
    takenAmount = json['taken_amount'];
    startedAt = json['started_at'];
    fiatCurrency = json['fiat_currency'];
    paymentMethod = json['payment_method'];
    transferStatus = json['transfer_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? userId;
  dynamic counterpartyId;
  String? tradeType;
  String? currency;
  String? amount;
  String? fiatAmount;
  dynamic takenAmount;
  dynamic startedAt;
  String? fiatCurrency;
  String? paymentMethod;
  String? transferStatus;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['counterparty_id'] = counterpartyId;
    map['trade_type'] = tradeType;
    map['currency'] = currency;
    map['amount'] = amount;
    map['fiat_amount'] = fiatAmount;
    map['taken_amount'] = takenAmount;
    map['started_at'] = startedAt;
    map['fiat_currency'] = fiatCurrency;
    map['payment_method'] = paymentMethod;
    map['transfer_status'] = transferStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}