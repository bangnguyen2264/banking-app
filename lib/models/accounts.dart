class Account {
  final int id;
  final String accountNumber;
  final double balance;
  final int userId;
  final List<dynamic>? transactions;

  Account({
    required this.id,
    required this.accountNumber,
    required this.balance,
    required this.userId,
    this.transactions,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      accountNumber: json['accountNumber'],
      balance: (json['balance'] as num).toDouble(),
      userId: json['userId'],
      transactions: json['transactions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNumber': accountNumber,
      'balance': balance,
      'userId': userId,
      'transactions': transactions,
    };
  }
}
