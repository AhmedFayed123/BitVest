import 'Ads.dart';

class AdsModel {
  AdsModel({
      this.status, 
      this.message, 
      this.ads,});

  AdsModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['ads'] != null) {
      ads = [];
      json['ads'].forEach((v) {
        ads?.add(Ads.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<Ads>? ads;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (ads != null) {
      map['ads'] = ads?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}