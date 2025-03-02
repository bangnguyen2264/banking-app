import 'package:bankingapp/models/transactions_report.dart';
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

  Future<List<TransactionReport>?> getReport(int accountId) async {
    try {
      print('getReport accountId: $accountId');
      final response =
          await ApiService().getList('/transactions/account/$accountId/trans');
      if (response != null) {
        List<TransactionReport> listFinal = response
            .map((transaction) => TransactionReport.fromJson(transaction))
            .toList();
        print(listFinal);
        return listFinal;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Exception in TransactionService.getReport: $e');
    }
  }

  Future<bool> depositMoney(Map<String, dynamic> body) async {
    try {
      final response = await ApiService().post('/transactions/deposit', body);
      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Exception in TransactionService.depositMoney: $e');
    }
  }
}
