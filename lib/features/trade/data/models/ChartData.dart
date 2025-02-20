class ChartData {
  ChartData({
    this.d7,
    this.d30,
    this.d90,
  });

  ChartData.fromJson(dynamic json) {
    d7 = json['7d'] != null ? List<List<dynamic>>.from(json['7d']) : [];
    d30 = json['30d'] != null ? List<List<dynamic>>.from(json['30d']) : [];
    d90 = json['90d'] != null ? List<List<dynamic>>.from(json['90d']) : [];
  }

  List<List<dynamic>>? d7;
  List<List<dynamic>>? d30;
  List<List<dynamic>>? d90;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['7d'] = d7;
    map['30d'] = d30;
    map['90d'] = d90;
    return map;
  }
}
