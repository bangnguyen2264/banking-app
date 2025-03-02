import 'package:bankingapp/models/accounts.dart';
import 'package:bankingapp/models/transactions_report.dart';
import 'package:bankingapp/models/user.dart';

User mockUser = User(
  id: 1,
  fullName: 'George Floyd',
  email: 'george@gmail.com',
  phoneNumber: '',
  accountNumber: [
    Account(
      id: 1,  
      accountNumber: '1234567890',
      customerId: 1,
      balance: 1000,
    ),
    Account(
      id: 2,
      accountNumber: '0987654321',
      customerId: 1,
      balance: 2000000,
    ),
    Account(
      id: 3,
      accountNumber: '981304981',
      customerId: 1,
      balance: 0,
    )
  ],
  address: '',
);

