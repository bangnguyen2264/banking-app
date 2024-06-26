import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/services/account_service.dart';
import 'package:bankingapp/services/api_service.dart';

class UserService {
  Future<User?> getById(int id) async {
    try {
      // Fetch user information
      final response = await ApiService().get('/customers/$id');
      if (response == null) {
        throw Exception('Failed to load user information');
      } else {
        print('Response: $response');
        // Return the User object
        return User.fromJsonAccount(response);
      }
    } catch (e) {
      print('Exception in UserService.getById: $e');
      throw Exception('Exception in UserService.getById: $e');
    }
  }

  Future<User?> getByAccountNumber( String accountNumber) async {
    final account =
        await AccountService().getAccountByNumber( accountNumber);
    if (account != null) {
      return getById(account.customerId);
    }
  }

  Future<User?> getMe() async {
    try {
      // Fetch user information
      final userInfor = await ApiService().get('/customers/me');
      if (userInfor == null) {
        throw Exception('Failed to load user information');
      }

      // Fetch account information using the user ID
      final accountInfor =
          await AccountService().getListAccount(userInfor['id']);
      if (accountInfor == null) {
        throw Exception('Failed to load account information');
      }

      // Construct the response map
      final response = {
        'id': userInfor['id'],
        'fullName': userInfor['fullName'],
        'email': userInfor['email'],
        'phoneNumber': userInfor['phoneNumber'],
        'address': userInfor['address'],
        'accountNumber':
            accountInfor.map((account) => account.toJson()).toList(),
      };

      // Print the response for debugging purposes
      print('Response: $response');

      // Return the User object
      return User.fromJson(response);
    } catch (e) {
      print(e);
      throw Exception('Exception in UserService.getMe: $e');
    }
  }

  Future<bool> update(int id, Map<String, dynamic> body) async {
    final response = await ApiService().update('/customers/$id', body);
    if (response) {
      return true;
    }
    return false;
  }
}
