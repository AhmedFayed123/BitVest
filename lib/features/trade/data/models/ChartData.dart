import '30d.dart';
import '7d.dart';
import '90d.dart';

class ChartData {
  List<SevenDays>? sevenDays;
  List<ThirtyDays>? thirtyDays;
  List<NinetyDays>? ninetyDays;

  ChartData({this.sevenDays, this.thirtyDays, this.ninetyDays});

  ChartData.fromJson(Map<String, dynamic> json) {
    if (json['7d'] != null) {
      sevenDays = [];
      json['7d'].forEach((v) {
        sevenDays?.add(SevenDays.fromJson(v));
      });
    }
    if (json['30d'] != null) {
      thirtyDays = [];
      json['30d'].forEach((v) {
        thirtyDays?.add(ThirtyDays.fromJson(v));
      });
    }
    if (json['90d'] != null) {
      ninetyDays = [];
      json['90d'].forEach((v) {
        ninetyDays?.add(NinetyDays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (sevenDays != null) {
      map['7d'] = sevenDays?.map((v) => v.toJson()).toList();
    }
    if (thirtyDays != null) {
      map['30d'] = thirtyDays?.map((v) => v.toJson()).toList();
    }
    if (ninetyDays != null) {
      map['90d'] = ninetyDays?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
