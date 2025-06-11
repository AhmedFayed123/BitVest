import 'CoinsOfTheUser.dart';

class Data {
  Data({
      this.coinsoftheuser, 
      this.numberofcoinstheuserpurchased,});

  Data.fromJson(dynamic json) {
    if (json['coins of the user'] != null) {
      coinsoftheuser = [];
      json['coins of the user'].forEach((v) {
        coinsoftheuser?.add(CoinsOfTheUser.fromJson(v));
      });
    }
    numberofcoinstheuserpurchased = json['number of coins the user purchased'];
  }
  List<CoinsOfTheUser>? coinsoftheuser;
  int? numberofcoinstheuserpurchased;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (coinsoftheuser != null) {
      map['coins of the user'] = coinsoftheuser?.map((v) => v.toJson()).toList();
    }
    map['number of coins the user purchased'] = numberofcoinstheuserpurchased;
    return map;
  }

}