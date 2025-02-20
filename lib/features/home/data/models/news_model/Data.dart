import 'SourceInfo.dart';

class Data {
  Data({
    this.id,
    this.guid,
    this.publishedOn,
    this.imageurl,
    this.title,
    this.url,
    this.body,
    this.tags,
    this.lang,
    this.upvotes,
    this.downvotes,
    this.categories,
    this.sourceInfo,
    this.source,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    guid = json['guid'];
    publishedOn = json['published_on'];
    imageurl = json['imageurl'];
    title = json['title'];
    url = json['url'];
    body = json['body'];
    tags = json['tags'];
    lang = json['lang'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    categories = json['categories'];
    sourceInfo = json['source_info'] != null ? SourceInfo.fromJson(json['source_info']) : null;
    source = json['source'];
  }

  String? id;
  String? guid;
  int? publishedOn;
  String? imageurl;
  String? title;
  String? url;
  String? body;
  String? tags;
  String? lang;
  String? upvotes;
  String? downvotes;
  String? categories;
  SourceInfo? sourceInfo;
  String? source;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['guid'] = guid;
    map['published_on'] = publishedOn;
    map['imageurl'] = imageurl;
    map['title'] = title;
    map['url'] = url;
    map['body'] = body;
    map['tags'] = tags;
    map['lang'] = lang;
    map['upvotes'] = upvotes;
    map['downvotes'] = downvotes;
    map['categories'] = categories;
    if (sourceInfo != null) {
      map['source_info'] = sourceInfo?.toJson();
    }
    map['source'] = source;
    return map;
  }
}
