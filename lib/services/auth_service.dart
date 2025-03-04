import 'dart:convert';
import 'package:bankingapp/utils/app_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'API_URL not found';
  final AppPreferences _appPreferences = Get.find<AppPreferences>();

  /// Xử lý đăng ký
  Future<bool> handleSignUp(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/register'),
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print('❌ Đăng ký thất bại: ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Exception in AuthService.signUp: $e');
    }
  }

  /// Xử lý đăng nhập
  Future<bool> handleSignIn(Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/auth/login'),
        headers: {
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Lưu token vào AppPreferences
        await _appPreferences.saveToSecureStorage(
            'accessToken', responseData['token']);

        return true;
      } else {
        print('❌ Đăng nhập thất bại: ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Exception in AuthService.signIn: $e');
    }
  }

  /// Lấy token từ AppPreferences
  Future<String?> getAccessToken() async {
    return _appPreferences.getFromSecureStorage('accessToken');
  }

  /// Đăng xuất và xóa token
  Future<void> logout() async {
    await _appPreferences.clearAll();
  }
}
