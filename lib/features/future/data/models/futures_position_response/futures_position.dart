class FuturesPosition {
  final int id;
  final int userId;
  final int futuresWalletId;
  final String currency;
  final String direction;
  final double entryPrice;
  final double size;
  final double leverage;
  final double margin;
  final double? unrealizedPnl; // ممكن تكون null لو الصفقة مغلقة
  final bool isOpen;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Wallet wallet;

  FuturesPosition({
    required this.id,
    required this.userId,
    required this.futuresWalletId,
    required this.currency,
    required this.direction,
    required this.entryPrice,
    required this.size,
    required this.leverage,
    required this.margin,
    required this.unrealizedPnl,
    required this.isOpen,
    required this.createdAt,
    required this.updatedAt,
    required this.wallet,
  });

  factory FuturesPosition.fromJson(Map<String, dynamic> json) {
    return FuturesPosition(
      id: json['id'],
      userId: json['user_id'],
      futuresWalletId: json['futures_wallet_id'],
      currency: json['currency'],
      direction: json['direction'],
      entryPrice: double.parse(json['entry_price']),
      size: double.parse(json['size']),
      leverage: double.parse(json['leverage']),
      margin: double.parse(json['margin']),
      unrealizedPnl: json['unrealized_pnl'] != null
          ? double.tryParse(json['unrealized_pnl'])
          : null,
      isOpen: json['is_open'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      wallet: Wallet.fromJson(json['wallet']),
    );
  }
}
class Wallet {
  final int id;
  final int userId;
  final String currency;
  final double balance;
  final double margin;
  final DateTime createdAt;
  final DateTime updatedAt;

  Wallet({
    required this.id,
    required this.userId,
    required this.currency,
    required this.balance,
    required this.margin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      userId: json['user_id'],
      currency: json['currency'],
      balance: double.parse(json['balance']),
      margin: double.parse(json['margin']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
