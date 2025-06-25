import 'FuturesWallets.dart';

class FutureWallet {
  FutureWallet({
      this.futuresWallets,});

  FutureWallet.fromJson(dynamic json) {
    if (json['futures_wallets'] != null) {
      futuresWallets = [];
      json['futures_wallets'].forEach((v) {
        futuresWallets?.add(FuturesWallets.fromJson(v));
      });
    }
  }
  List<FuturesWallets>? futuresWallets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (futuresWallets != null) {
      map['futures_wallets'] = futuresWallets?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}