import 'Data.dart';

class BuySellModel {
  BuySellModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  BuySellModel.fromJson(dynamic json) {
    final rawSuccess = json['success'];
    success = rawSuccess == true || rawSuccess.toString().toLowerCase() == 'true';
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
