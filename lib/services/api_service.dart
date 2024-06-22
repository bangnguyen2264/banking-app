import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<Map<String, dynamic>?> get(String path) async {
    final token = getSavedToken();

    try {
      final response = await http.get(
        Uri.parse('$path'),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Charset': 'utf-8',
          'Authorization': '$token',
        },
      );
      if (response.statusCode == 200) {
        print('Response: ${utf8.decode(response.bodyBytes)}');

        ;
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print('Failed to load data ${response.body}');
        return null;
      }
    } catch (e) {
      throw Exception('Exception in ApiService.get: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> getList(String path) async {
    final token = await getSavedToken(); // Await token retrieval

    try {
      final response = await http.get(
        Uri.parse('$path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData =
            jsonDecode(utf8.decode(response.bodyBytes));
        print('Content  ${jsonData['content']}');
        return (jsonData['content']).cast<Map<String, dynamic>>();
      } else {
        print('Failed to load data ${response.body}');
        return null;
      }
    } catch (e) {
      throw Exception('Exception in ApiService.getList: $e');
    }
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> body) async {
    final token = await getSavedToken(); // Await token retrieval

    try {
      final response = await http.post(
        Uri.parse('$path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print('Failed to load data ${response.body}');
        return {};
      }
    } catch (e) {
      throw Exception('Exception in ApiService.post: $e');
    }
  }

  Future<bool> put(String path, Map<String, dynamic> body) async {
    final token = await getSavedToken(); // Await token retrieval

    try {
      final response = await http.put(
        Uri.parse('$path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to load data ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Exception in ApiService.put: $e');
    }
  }

  Future<bool> delete(String path) async {
    final token = await getSavedToken(); // Await token retrieval

    try {
      final response = await http.delete(
        Uri.parse('$path'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to load data ${response.body}');
        return false;
      }
    } catch (e) {
      throw Exception('Exception in ApiService.delete: $e');
    }
  }

  Future<String?> getSavedToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
