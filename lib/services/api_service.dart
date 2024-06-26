import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final apiUrl = dotenv.env['API_URL'] ?? 'API_URL not found';

  Future<Map<String, dynamic>?> get(String path) async {
    final token = await getAccessToken();
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}${path}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
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

  Future<List<Map<String, dynamic>>?> getList(String path) async {
    final token = await getAccessToken();

    try {
      final response = await http.get(
        Uri.parse('${apiUrl}${path}'), // Replace with your API base URL
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        // Decode the JSON response body
        List<dynamic> jsonData = jsonDecode(response.body);

        // Convert List<dynamic> to List<Map<String, dynamic>>
        List<Map<String, dynamic>> dataList =
            jsonData.cast<Map<String, dynamic>>();

        return dataList;
      } else {
        // Handle failed request
        print('Failed to load data: ${response.body}');
        return null; // Return null when request fails
      }
    } catch (e) {
      // Handle exceptions
      throw Exception('Exception in ApiService.getList: $e');
    }
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> body) async {
    final token = await getAccessToken(); // Await token retrieval

    try {
      final response = await http.post(
        Uri.parse('${apiUrl}${path}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print('Failed to load data ${response.body}');
        return {};
      }
    } catch (e) {
      print('Exception in ApiService.post: $e');
      throw Exception('Exception in ApiService.post: $e');
    }
  }

  Future<bool> update(String path, Map<String, dynamic> body) async {
    final token = await getAccessToken(); // Await token retrieval

    try {
      final response = await http.patch(
        Uri.parse('${apiUrl}${path}'),
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
    final token = await getAccessToken(); // Await token retrieval

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

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
