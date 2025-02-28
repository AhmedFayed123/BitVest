import 'AthDate.dart';
import 'AtlDate.dart';
import 'ChartData.dart';

class Original {
  Original({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.fullyDilutedValuation,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.marketCapChange24h,
    this.marketCapChangePercentage24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.athDate,
    this.atl,
    this.atlChangePercentage,
    this.atlDate,
    this.lastUpdated,
    this.chartData,
  });

  Original.fromJson(dynamic json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];

    // ✅ تحويل القيم إلى double إذا كانت int
    currentPrice = (json['current_price'] as num?)?.toDouble();
    marketCap = (json['market_cap'] as num?)?.toDouble();
    fullyDilutedValuation = (json['fully_diluted_valuation'] as num?)?.toDouble();
    totalVolume = (json['total_volume'] as num?)?.toDouble();
    high24h = (json['high_24h'] as num?)?.toDouble();
    low24h = (json['low_24h'] as num?)?.toDouble();
    priceChange24h = (json['price_change_24h'] as num?)?.toDouble();
    priceChangePercentage24h = (json['price_change_percentage_24h'] as num?)?.toDouble();
    marketCapChange24h = (json['market_cap_change_24h'] as num?)?.toDouble();
    marketCapChangePercentage24h = (json['market_cap_change_percentage_24h'] as num?)?.toDouble();
    circulatingSupply = (json['circulating_supply'] as num?)?.toDouble();
    totalSupply = (json['total_supply'] as num?)?.toDouble();
    maxSupply = (json['max_supply'] as num?)?.toDouble();
    ath = (json['ath'] as num?)?.toDouble();
    athChangePercentage = (json['ath_change_percentage'] as num?)?.toDouble();
    atl = (json['atl'] as num?)?.toDouble();
    atlChangePercentage = (json['atl_change_percentage'] as num?)?.toDouble();

    // ✅ قراءة التواريخ والموديلات الفرعية بشكل صحيح
    athDate = json['ath_date'] != null ? AthDate.fromJson(json['ath_date']) : null;
    atlDate = json['atl_date'] != null ? AtlDate.fromJson(json['atl_date']) : null;
    lastUpdated = json['last_updated'];
    chartData = json['chart_data'] != null ? ChartData.fromJson(json['chart_data']) : null;
  }

  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? fullyDilutedValuation;
  double? totalVolume;
  double? high24h;
  double? low24h;
  double? priceChange24h;
  double? priceChangePercentage24h;
  double? marketCapChange24h;
  double? marketCapChangePercentage24h;
  double? circulatingSupply;
  double? totalSupply;
  double? maxSupply;
  double? ath;
  double? athChangePercentage;
  AthDate? athDate;
  double? atl;
  double? atlChangePercentage;
  AtlDate? atlDate;
  String? lastUpdated;
  ChartData? chartData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['symbol'] = symbol;
    map['name'] = name;
    map['image'] = image;
    map['current_price'] = currentPrice;
    map['market_cap'] = marketCap;
    map['market_cap_rank'] = marketCapRank;
    map['fully_diluted_valuation'] = fullyDilutedValuation;
    map['total_volume'] = totalVolume;
    map['high_24h'] = high24h;
    map['low_24h'] = low24h;
    map['price_change_24h'] = priceChange24h;
    map['price_change_percentage_24h'] = priceChangePercentage24h;
    map['market_cap_change_24h'] = marketCapChange24h;
    map['market_cap_change_percentage_24h'] = marketCapChangePercentage24h;
    map['circulating_supply'] = circulatingSupply;
    map['total_supply'] = totalSupply;
    map['max_supply'] = maxSupply;
    map['ath'] = ath;
    map['ath_change_percentage'] = athChangePercentage;

    if (athDate != null) {
      map['ath_date'] = athDate?.toJson();
    }

    map['atl'] = atl;
    map['atl_change_percentage'] = atlChangePercentage;

    if (atlDate != null) {
      map['atl_date'] = atlDate?.toJson();
    }

    map['last_updated'] = lastUpdated;

    if (chartData != null) {
      map['chart_data'] = chartData?.toJson();
    }

    return map;
  }
}
