import 'Data.dart';

class NewsModel {
  NewsModel({
    this.type,
    this.message,
    this.promoted,
    this.data,
    this.rateLimit,
    this.hasWarning,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      type: json['Type'] as int?,
      message: json['Message'] as String?,
      promoted: json['Promoted'] != null
          ? List<Map<String, dynamic>>.from(json['Promoted'] is List ? json['Promoted'].map((x) => x as Map<String, dynamic>) : [])
          : null,
      data: json['Data'] != null
          ? (json['Data'] is List ? (json['Data'] as List).map((v) => Data.fromJson(v as Map<String, dynamic>)).toList() : [])
          : null,
      rateLimit: json['RateLimit'] as int?,
      hasWarning: json['HasWarning'] as bool?,
    );
  }

  int? type;
  String? message;
  List<Map<String, dynamic>>? promoted;
  List<Data>? data;
  int? rateLimit;
  bool? hasWarning;

  Map<String, dynamic> toJson() {
    return {
      'Type': type,
      'Message': message,
      'Promoted': promoted,
      'Data': data?.map((v) => v.toJson()).toList(),
      'RateLimit': rateLimit,
      'HasWarning': hasWarning,
    };
  }
}
