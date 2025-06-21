class EditRequest {
  EditRequest({
    this.id,          // أضفت هنا
    this.currency,
    this.amount,
    this.fiatAmount,
    this.fiatCurrency,
    this.paymentMethod,
    this.paymentDetails,
  });

  EditRequest.fromJson(dynamic json) {
    id = json['id'];             // أضفت هنا
    currency = json['currency'];
    amount = json['amount'];
    fiatAmount = json['fiat_amount'];
    fiatCurrency = json['fiat_currency'];
    paymentMethod = json['payment_method'];
    paymentDetails = json['payment_details'];
  }

  int? id;              // معرف الإعلان المراد تعديله
  String? currency;
  double? amount; // تم التعديل
  double? fiatAmount;
  String? fiatCurrency;
  String? paymentMethod;
  String? paymentDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'currency': currency,
      'amount': amount,
      'fiat_amount': fiatAmount,
      'fiat_currency': fiatCurrency,
      'payment_method': paymentMethod,
      'payment_details': paymentDetails,
    };

    print('EditRequest toJson: $map');
    return map;
  }

}
