import 'ChartData.dart';

class Original {
  Original({
    this.id,
    this.name,
    this.symbol,
    this.icon,
    this.price,
    this.changeRatePercentage,
    this.changeRateUsdt,
    this.chartData,
  });

  Original.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    icon = json['icon'];

    // تأكد من أن السعر رقم، وحوله إلى double في حال كان int
    price = (json['price'] as num?)?.toDouble();
    changeRatePercentage = (json['change_rate_percentage'] as num?)?.toDouble();
    changeRateUsdt = (json['change_rate_usdt'] as num?)?.toDouble();

    chartData = json['chart_data'] != null ? ChartData.fromJson(json['chart_data']) : null;
  }

  String? id;
  String? name;
  String? symbol;
  String? icon;
  double? price;
  double? changeRatePercentage;
  double? changeRateUsdt;
  ChartData? chartData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['symbol'] = symbol;
    map['icon'] = icon;
    map['price'] = price;
    map['change_rate_percentage'] = changeRatePercentage;
    map['change_rate_usdt'] = changeRateUsdt;
    if (chartData != null) {
      map['chart_data'] = chartData?.toJson();
    }
    return map;
  }
}
