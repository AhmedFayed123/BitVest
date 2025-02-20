import 'Original.dart';

class CoinDataModel {
  CoinDataModel({
      this.headers, 
      this.original, 
      this.exception,});

  CoinDataModel.fromJson(dynamic json) {
    headers = json['headers'];
    original = json['original'] != null ? Original.fromJson(json['original']) : null;
    exception = json['exception'];
  }
  dynamic headers;
  Original? original;
  dynamic exception;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['headers'] = headers;
    if (original != null) {
      map['original'] = original?.toJson();
    }
    map['exception'] = exception;
    return map;
  }

}