import 'dart:convert';

import 'package:bankingapp/models/accounts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class AccountService {
  final dio = Dio();

  Future<List<Account>> getListAccount(int id) async {
    try {
      // Assuming ApiService().getList returns a List<dynamic>
      final response = await ApiService().getList('/customers/$id/accounts');
      if (response != null) {
        return response.map((account) => Account.fromJson(account)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Exception in AccountService.getListAccount: $e');
    }
  }

  Future<Account?> getAccountByNumber(String accountNumber) async {
    final token = await ApiService().getAccessToken();
    try {
      final uri = Uri.parse(
          '${ApiService().apiUrl}/customers/1/accounts/account-number/id');

      final request = http.Request('GET', uri)
        ..headers['Content-Type'] = 'application/json'
        ..headers['Authorization'] = '$token'
        ..body = jsonEncode({'accountNumber': accountNumber});

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData.isNotEmpty) {
          return Account.fromJson(jsonData);
        }
      } else {
        print(
            'Failed to load data in AccountService.getAccountByNumber: ${response.body}');
      }
    } catch (e) {
      print('Exception in AccountService.getAccountByNumber: $e');
      throw Exception('Failed to fetch account details');
    }
  }

  Future<Account?> createAccount(int customerId) async {
    try {
      // Generate account number
      final generateAccountNumberResponse = await ApiService()
          .get('/customers/$customerId/accounts/generate-account-number');

      if (generateAccountNumberResponse == null ||
          generateAccountNumberResponse['generatedAccountNumber'] == null) {
        // Handle error: failed to generate account number
        throw Exception('Failed to generate account number');
      }

      final body = {
        "accountNumber":
            generateAccountNumberResponse['generatedAccountNumber'],
      };

      // Create account
      final accountResponse =
          await ApiService().post('/customers/$customerId/accounts', body);

      if (accountResponse == null) {
        // Handle error: failed to create account
        throw Exception('Failed to create account');
      }

      return Account.fromJson(accountResponse);
    } catch (e) {
      // Handle exception
      print('Error creating account: $e');
      throw Exception(
          'Failed to create account in AccountService.creatAccount: $e');
    }
  }
}
