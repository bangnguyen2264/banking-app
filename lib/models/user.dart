import 'package:bankingapp/models/accounts.dart';

class User {
  int id;
  String fullName;
  String email;
  String phoneNumber;
  List<Account> accountNumber;
  String address;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.accountNumber,
    required this.address,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullName = json['fullName'] ?? '',
        email = json['email'] ?? '',
        phoneNumber = json['phoneNumber'] ?? '',
        accountNumber = json['accountNumber'] ?? '',
        address = json['address'] ?? '';

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
        'address': address,
      };
}
