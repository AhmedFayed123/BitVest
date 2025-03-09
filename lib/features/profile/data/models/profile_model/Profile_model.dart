import 'ProfilePicture.dart';

class ProfileModel {
  ProfileModel({
      this.id, 
      this.email, 
      this.name, 
      this.createdAt, 
      this.updatedAt, 
      this.profilePicture,});

  ProfileModel.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePicture = json['profile_picture'] != null ? ProfilePicture.fromJson(json['profile_picture']) : null;
  }
  int? id;
  String? email;
  String? name;
  String? createdAt;
  String? updatedAt;
  ProfilePicture? profilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (profilePicture != null) {
      map['profile_picture'] = profilePicture?.toJson();
    }
    return map;
  }

}