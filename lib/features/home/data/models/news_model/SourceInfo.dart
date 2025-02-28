class SourceInfo {
  SourceInfo({
      this.name, 
      this.img, 
      this.lang,});

  SourceInfo.fromJson(dynamic json) {
    name = json['name'];
    img = json['img'];
    lang = json['lang'];
  }
  String? name;
  String? img;
  String? lang;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['img'] = img;
    map['lang'] = lang;
    return map;
  }

}