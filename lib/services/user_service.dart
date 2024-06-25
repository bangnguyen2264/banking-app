import 'dart:math';

import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/services/api_service.dart';

class UserService {
  Future<User> getMe() async {
    try {
      final response = await ApiService().get('/customers/me');
      if (response != null) {
        return User.fromJson(response);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Exception in UserService.getMe: $e');
    }
  }
}
