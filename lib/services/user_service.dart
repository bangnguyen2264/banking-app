import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/services/account_service.dart';
import 'package:bankingapp/services/api_service.dart';

class UserService {
  Future<User?> getById(int id) async {
    try {
      // Fetch user information
      final response = await ApiService().get(path: '/customers/$id');
      if (response == null) {
        throw Exception('Failed to load user information');
      } else {
        print('Response: $response');
        // Return the User object
        return User.fromJson(response);
      }
    } catch (e) {
      print('Exception in UserService.getById: $e');
      throw Exception('Exception in UserService.getById: $e');
    }
  }

  Future<User?> getByAccountNumber(String accountNumber) async {
    final account = await AccountService()
        .getAccountByNumber(accountNumber)
        .onError((error, stackTrace) => null);
    if (account != null) {
      return getById(account.userId);
    }
  }

  Future<User?> getMe() async {
    try {
      // Fetch user information
      final response = await ApiService().get(path: '/user/get/me');
      if (response == null) {
        throw Exception('Failed to load user information');
      } else {
        print('Response: $response');
        // Return the User object
        return User.fromJson(response);
      }
    } catch (e) {
      print(e);
      throw Exception('Exception in UserService.getMe: $e');
    }
  }

  Future<bool> update(int id, Map<String, dynamic> body) async {
    final response = await ApiService().update(
      path: '/user/update/me',
      body: body,
    );
    
    if (response) {
      return true;
    }
    return false;
  }
}
