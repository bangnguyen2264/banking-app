import 'package:bankingapp/models/accounts.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class AccountService {
  Future<List<Account>> getListAccount(int id) async {
    try {
      // Assuming ApiService().getList returns a List<dynamic>
      final response = await ApiService().getList('/customers/$id/accounts');
      if (response != null ) {
        return response.map((account) => Account.fromJson(account)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Exception in AccountService.getListAccount: $e');
    }
  }
}
