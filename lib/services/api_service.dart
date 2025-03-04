import 'dart:async';
import 'dart:convert';
import 'package:bankingapp/utils/app_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'API_URL not found';
  final AppPreferences _appPreferences = Get.find<AppPreferences>();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _appPreferences.getFromSecureStorage('accessToken');
    return {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>?> get({required String path}) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl$path'),
        headers: await _getHeaders(),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to load data ${response.body}');
        return null;
      }
    } catch (e) {
      throw Exception('Exception in ApiService.get: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> getList({required String path}) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl$path'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.cast<Map<String, dynamic>>();
      } else {
        print('Failed to load data: ${response.body}');
        return null;
      }
    } catch (e) {
      throw Exception('Exception in ApiService.getList: $e');
    }
  }

  Future<Map<String, dynamic>> post({
    required String path,
    Map<String, dynamic>? body, // body có thể có hoặc không
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl$path'),
        headers: await _getHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print('Failed to post data: ${response.body}');
        return {};
      }
    } catch (e) {
      throw Exception('Exception in ApiService.post: $e');
    }
  }

  Future<bool> update({
    required String path,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse('$apiUrl$path'),
        headers: await _getHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Exception in ApiService.update: $e');
    }
  }

  Future<bool> delete({required String path}) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl$path'),
        headers: await _getHeaders(),
      );
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Exception in ApiService.delete: $e');
    }
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
