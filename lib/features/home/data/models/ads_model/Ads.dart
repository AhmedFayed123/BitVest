class Ads {
  Ads({
      this.imageUrl, 
      this.text,});

  Ads.fromJson(dynamic json) {
    imageUrl = json['image_url'];
    text = json['text'];
  }
  String? imageUrl;
  String? text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_url'] = imageUrl;
    map['text'] = text;
    return map;
  }

}