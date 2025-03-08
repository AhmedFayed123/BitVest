class ProfileModel {
  ProfileModel({
      this.id, 
      this.email, 
      this.name, 
      this.createdAt, 
      this.updatedAt,});

  ProfileModel.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? email;
  String? name;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}