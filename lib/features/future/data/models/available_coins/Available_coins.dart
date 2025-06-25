import 'FuturesAvailableCoins.dart';

class AvailableCoins {
  AvailableCoins({
      this.futuresAvailableCoins, 
      this.userFuturesWalletCoins, 
      this.userAvailableToTradeFutures,});

  AvailableCoins.fromJson(dynamic json) {
    if (json['futures_available_coins'] != null) {
      futuresAvailableCoins = [];
      json['futures_available_coins'].forEach((v) {
        futuresAvailableCoins?.add(FuturesAvailableCoins.fromJson(v));
      });
    }
    userFuturesWalletCoins = json['user_futures_wallet_coins'] != null ? json['user_futures_wallet_coins'].cast<String>() : [];
    userAvailableToTradeFutures = json['user_available_to_trade_futures'] != null ? json['user_available_to_trade_futures'].cast<String>() : [];
  }
  List<FuturesAvailableCoins>? futuresAvailableCoins;
  List<String>? userFuturesWalletCoins;
  List<String>? userAvailableToTradeFutures;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (futuresAvailableCoins != null) {
      map['futures_available_coins'] = futuresAvailableCoins?.map((v) => v.toJson()).toList();
    }
    map['user_futures_wallet_coins'] = userFuturesWalletCoins;
    map['user_available_to_trade_futures'] = userAvailableToTradeFutures;
    return map;
  }

}