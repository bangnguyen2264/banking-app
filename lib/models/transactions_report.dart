class TransactionReport {
  final int id;
  final int accountId;
  final String toAccountNumber;
  final String transactionType;
  final int amount;
  final String transactionDate;
  final String description;
  TransactionReport({
    required this.id,
    required this.accountId,
    required this.toAccountNumber,
    required this.transactionType,
    required this.amount,
    required this.transactionDate,
    required this.description,
  });
  TransactionReport.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        accountId = json['accountId'] ?? 0,
        toAccountNumber = json['toAccountNumber'] ?? '',
        transactionType = json['transactionType'] ,
        amount = json['amount'] ?? 0,
        transactionDate = json['transactionDate'],
        description = json['description'] ?? '';
}
