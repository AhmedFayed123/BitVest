import 'Favourites_Data.dart';

class FavouritesModel {
  FavouritesModel({
      this.message, 
      this.data,});

  FavouritesModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FavouritesData.fromJson(v));
      });
    }
  }
  String? message;
  List<FavouritesData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}