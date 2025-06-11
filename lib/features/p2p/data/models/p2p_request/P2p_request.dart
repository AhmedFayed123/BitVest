class P2pRequest {
  P2pRequest({
    this.currency,
    this.amount,
    this.fiatAmount,
    this.fiatCurrency,
    this.paymentMethod,
  });

  P2pRequest.fromJson(dynamic json) {
    currency = json['currency'];
    amount = _parseInt(json['amount']);
    fiatAmount = _parseInt(json['fiat_amount']);
    fiatCurrency = json['fiat_currency'];
    paymentMethod = json['payment_method'];
  }

  String? currency;
  int? amount;
  int? fiatAmount;
  String? fiatCurrency;
  String? paymentMethod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = currency;
    map['amount'] = amount;
    map['fiat_amount'] = fiatAmount;
    map['fiat_currency'] = fiatCurrency;
    map['payment_method'] = paymentMethod;
    return map;
  }

  // Helper method to safely parse integers
  int? _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value);
    } else if (value is int) {
      return value;
    }
    return null;
  }
}
