import 'FavouriteCurrency.dart';

class Data {
  Data({
      this.favouritecurrency,});

  Data.fromJson(dynamic json) {
    favouritecurrency = json['favourite currency'] != null ? FavouriteCurrency.fromJson(json['favourite currency']) : null;
  }
  FavouriteCurrency? favouritecurrency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (favouritecurrency != null) {
      map['favourite currency'] = favouritecurrency?.toJson();
    }
    return map;
  }

}