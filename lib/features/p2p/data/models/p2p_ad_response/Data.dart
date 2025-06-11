class Data {
  Data({
    this.userId,
    this.tradeType,
    this.currency,
    this.amount,
    this.fiatAmount,
    this.fiatCurrency,
    this.paymentMethod,
    this.transferStatus,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    tradeType = json['trade_type'];
    currency = json['currency'];
    amount = _parseInt(json['amount']);
    fiatAmount = _parseInt(json['fiat_amount']);
    fiatCurrency = json['fiat_currency'];
    paymentMethod = json['payment_method'];
    transferStatus = json['transfer_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  int? userId;
  String? tradeType;
  String? currency;
  int? amount; // Changed to int
  int? fiatAmount; // Changed to int
  String? fiatCurrency;
  String? paymentMethod;
  String? transferStatus;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['trade_type'] = tradeType;
    map['currency'] = currency;
    map['amount'] = amount;
    map['fiat_amount'] = fiatAmount;
    map['fiat_currency'] = fiatCurrency;
    map['payment_method'] = paymentMethod;
    map['transfer_status'] = transferStatus;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }

  // Helper method to safely parse integers from dynamic values
  int? _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value);
    } else if (value is int) {
      return value;
    }
    return null;
  }
}