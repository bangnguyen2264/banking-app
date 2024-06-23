import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final apiUrl = dotenv.env['API_URL'] ?? 'API_URL not found';

  Future<bool> handleSignUp(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        
        Uri.parse('$apiUrl/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
        
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to load data ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Exception in AuthService.signUp: $e');
    }
  }

  Future<bool> handleSignIn(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String accessToken = 'Bearer ${responseData['accessToken']}';
        final String refreshToken = 'Bearer ${responseData['refreshToken']}';
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('accessToken', accessToken);
        prefs.setString('refreshToken', refreshToken);
        return true;
      } else {
        print('Failed to load data ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Exception in AuthService.signIn: $e');
    }
  }
}
