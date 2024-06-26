import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/services/account_service.dart';
import 'package:bankingapp/services/api_service.dart';

class UserService {
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
}
