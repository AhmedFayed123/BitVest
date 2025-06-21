class Wallets {
  Wallets({
    this.coin,
    this.balance,
    this.currentPrice,
    this.valueUsd,
    this.hChangePercent,
    this.profitLossUsd,
  });

  String? coin;
  double? balance;
  double? currentPrice;
  double? valueUsd;
  double? hChangePercent;
  double? profitLossUsd;

  Wallets.fromJson(dynamic json) {
    coin = json['coin'];
    balance = _toDouble(json['balance']);
    currentPrice = _toDouble(json['current_price']);
    valueUsd = _toDouble(json['value_usd']);
    hChangePercent = _toDouble(json['24h_change_percent']);
    profitLossUsd = _toDouble(json['profit_loss_usd']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coin'] = coin;
    map['balance'] = balance;
    map['current_price'] = currentPrice;
    map['value_usd'] = valueUsd;
    map['24h_change_percent'] = hChangePercent;
    map['profit_loss_usd'] = profitLossUsd;
    return map;
  }

  /// ✅ دالة خاصة لتحويل أي قيمة لـ double (سواء كانت int، double، أو String)
  double? _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}
