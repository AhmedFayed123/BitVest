import 'News.dart';

class NewsModel {
  NewsModel({
      this.news,});

  NewsModel.fromJson(dynamic json) {
    news = json['news'] != null ? News.fromJson(json['news']) : null;
  }
  News? news;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (news != null) {
      map['news'] = news?.toJson();
    }
    return map;
  }

}