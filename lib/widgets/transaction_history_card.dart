import 'package:bankingapp/models/transactions_report.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionHistoryCard extends StatefulWidget {
  final TransactionReport transactionReport;
  const TransactionHistoryCard({
    super.key,
    required this.transactionReport,
  });

  @override
  State<TransactionHistoryCard> createState() => _TransactionHistoryCardState();
}

class _TransactionHistoryCardState extends State<TransactionHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: CircleAvatar(
        backgroundColor: widget.transactionReport.transactionType == 'TRANSFER'
            ? Colors.red
            : widget.transactionReport.transactionType == 'DEPOSIT'
                ? Colors.blue
                : widget.transactionReport.transactionType == 'RECEIVE'
                    ? Colors.green
                    : Colors.orange,
        child: Icon(Icons.monetization_on, color: Colors.white),
      ),
      title: Text(
        widget.transactionReport.transactionType == 'TRANSFER'
            ? 'Transger to account ${widget.transactionReport.toAccountNumber}'
            : widget.transactionReport.transactionType == 'DEPOSIT'
                ? 'Deposited into the account'
                : widget.transactionReport.transactionType == 'RECEIVE'
                    ? widget.transactionReport.description
                    : 'Withdraw from the account',
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatMoney(widget.transactionReport.amount),
          ),
          Text(formatDate(widget.transactionReport.transactionDate)),
        ],
      ),
    ));
  }
}
