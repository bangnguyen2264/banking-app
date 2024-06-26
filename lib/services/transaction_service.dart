import 'package:bankingapp/services/api_service.dart';

class TransactionService {
  Future<bool> transferMoney(Map<String, dynamic> body) async {
    try {
      final response = await ApiService().post('/transactions/transfer', body);
      if (response != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Exception in TransactionService.transferMoney: $e');
    }
  }
}
