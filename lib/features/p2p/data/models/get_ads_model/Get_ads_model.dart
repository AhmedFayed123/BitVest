import 'Data.dart';

class GetAdsModel {
  GetAdsModel({
      this.message, 
      this.data,});

  GetAdsModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AdsData.fromJson(v));
      });
    }
  }
  String? message;
  List<AdsData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}