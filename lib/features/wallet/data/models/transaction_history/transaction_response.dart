class TransactionsResponse {
  final bool success;
  final String message;
  final List<TransactionModel> transactions;

  TransactionsResponse({
    required this.success,
    required this.message,
    required this.transactions,
  });

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final transactionsList = data.values
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return TransactionsResponse(
      success: json['success'],
      message: json['message'],
      transactions: transactionsList,
    );
  }
}

class TransactionModel {
  final int id;
  final int walletId;
  final String transactionType;
  final String amount;
  final String currency;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransactionModel({
    required this.id,
    required this.walletId,
    required this.transactionType,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      walletId: json['wallet_id'],
      transactionType: json['transaction_type'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
