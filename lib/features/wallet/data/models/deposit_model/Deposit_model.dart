class DepositModel {
  DepositModel({
      this.iframeUrl, 
      this.paymentId,});

  DepositModel.fromJson(dynamic json) {
    iframeUrl = json['iframe_url'];
    paymentId = json['payment_id'];
  }
  String? iframeUrl;
  int? paymentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iframe_url'] = iframeUrl;
    map['payment_id'] = paymentId;
    return map;
  }

}