import 'package:bankingapp/models/accounts.dart';

class User {
  int id;
  String fullName;
  String? dob;
  String email;
  String? phone;
  String? address;
  Account account;

  User({
    required this.id,
    required this.fullName,
    this.dob,
    required this.email,
    this.phone,
    this.address,
    required this.account,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      dob: json['dob'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      account: Account.fromJson(json['account']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'dob': dob,
      'email': email,
      'phone': phone,
      'address': address,
      'account': account.toJson(),
    };
  }
}
