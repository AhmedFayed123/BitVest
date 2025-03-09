class ProfilePicture {
  ProfilePicture({
      this.url, 
      this.fileName, 
      this.size, 
      this.mimeType,});

  ProfilePicture.fromJson(dynamic json) {
    url = json['url'];
    fileName = json['file_name'];
    size = json['size'];
    mimeType = json['mime_type'];
  }
  String? url;
  String? fileName;
  int? size;
  String? mimeType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['file_name'] = fileName;
    map['size'] = size;
    map['mime_type'] = mimeType;
    return map;
  }

}