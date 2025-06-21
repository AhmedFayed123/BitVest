import 'Wallets.dart';

class Data {
  Data({
    this.wallets,
    this.totalBalanceUsd,
    this.totalProfitLossUsd,
    this.totalProfitLossPercentage,
    this.usdtWalletBalance,
  });

  Data.fromJson(dynamic json) {
    if (json['wallets'] != null) {
      wallets = [];
      json['wallets'].forEach((v) {
        wallets?.add(Wallets.fromJson(v));
      });
    }

    // ✅ التحويل الآمن من int أو double إلى double
    totalBalanceUsd = (json['total_balance_usd'] as num?)?.toDouble();
    totalProfitLossUsd = (json['total_profit_loss_usd'] as num?)?.toDouble();
    totalProfitLossPercentage = (json['total_profit_loss_percentage'] as num?)?.toDouble();
    usdtWalletBalance = (json['usdt_wallet_balance'] as num?)?.toDouble();
  }

  List<Wallets>? wallets;
  double? totalBalanceUsd;
  double? totalProfitLossUsd;
  double? totalProfitLossPercentage;
  double? usdtWalletBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (wallets != null) {
      map['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    map['total_balance_usd'] = totalBalanceUsd;
    map['total_profit_loss_usd'] = totalProfitLossUsd;
    map['total_profit_loss_percentage'] = totalProfitLossPercentage;
    map['usdt_wallet_balance'] = usdtWalletBalance;
    return map;
  }
}
