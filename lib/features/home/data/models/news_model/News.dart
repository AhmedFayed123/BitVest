import 'news_data.dart';

class News {
  News({
    this.type,
    this.message,
    this.promoted,
    this.data,
    this.rateLimit,
    this.hasWarning,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      type: json['Type'],
      message: json['Message'],
      promoted: json['Promoted'] != null
          ? List<Map<String, dynamic>>.from(json['Promoted'])
          : null,
      data: json['Data'] != null
          ? List<NewsData>.from(json['Data'].map((v) => NewsData.fromJson(v)))
          : null,
      rateLimit: json['RateLimit'] != null
          ? List<Map<String, dynamic>>.from(json['RateLimit'])
          : null,
      hasWarning: json['HasWarning'],
    );
  }

  int? type;
  String? message;
  List<Map<String, dynamic>>? promoted;
  List<NewsData>? data;
  List<Map<String, dynamic>>? rateLimit;
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
