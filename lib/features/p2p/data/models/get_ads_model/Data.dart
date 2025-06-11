import 'User.dart';

class AdsData {
  AdsData({
      this.id, 
      this.userId, 
      this.counterpartyId, 
      this.tradeType, 
      this.currency, 
      this.amount, 
      this.fiatAmount, 
      this.fiatCurrency, 
      this.paymentMethod, 
      this.transferStatus, 
      this.createdAt, 
      this.updatedAt, 
      this.user,});

  AdsData.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    counterpartyId = json['counterparty_id'];
    tradeType = json['trade_type'];
    currency = json['currency'];
    amount = json['amount'];
    fiatAmount = json['fiat_amount'];
    fiatCurrency = json['fiat_currency'];
    paymentMethod = json['payment_method'];
    transferStatus = json['transfer_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? id;
  int? userId;
  dynamic counterpartyId;
  String? tradeType;
  String? currency;
  String? amount;
  String? fiatAmount;
  String? fiatCurrency;
  String? paymentMethod;
  String? transferStatus;
  String? createdAt;
  String? updatedAt;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['counterparty_id'] = counterpartyId;
    map['trade_type'] = tradeType;
    map['currency'] = currency;
    map['amount'] = amount;
    map['fiat_amount'] = fiatAmount;
    map['fiat_currency'] = fiatCurrency;
    map['payment_method'] = paymentMethod;
    map['transfer_status'] = transferStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}