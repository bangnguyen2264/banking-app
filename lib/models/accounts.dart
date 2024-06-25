class Account {
  int id;
  String accountNumber;
  int customerId;
  int balance;
  Account({
    required this.id,
    required this.accountNumber,
    required this.customerId,
    required this.balance,
  });
  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        accountNumber = json['accountNumber'],
        customerId = json['customerId'],
        balance = json['balance'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'accountNumber': accountNumber,
        'customerId': customerId,
        'balance': balance,
      };
}
