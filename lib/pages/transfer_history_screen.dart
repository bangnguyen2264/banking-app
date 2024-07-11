import 'package:bankingapp/models/transactions_report.dart';
import 'package:bankingapp/services/transaction_service.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/appbar_custom.dart';
import 'package:bankingapp/utils/mock_data.dart';
import 'package:bankingapp/widgets/transaction_history_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TransferHistoryScreen extends StatefulWidget {
  final int? accountId;
  const TransferHistoryScreen({super.key, required this.accountId});

  @override
  State<TransferHistoryScreen> createState() => _TransferHistoryScreenState();
}

class _TransferHistoryScreenState extends State<TransferHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0.1 * Constants.deviceWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppbar(
            title: 'Transfer History',
          ),
          FutureBuilder(
              future: TransactionService().getReport(widget.accountId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<TransactionReport> transactionReports =
                      snapshot.data as List<TransactionReport>;
                  if (transactionReports.isEmpty) {
                    return _buildEmptyList();
                  }
                  return _buildListReport(transactionReports);
                }
              })
        ],
      ),
    ));
  }

  Widget _buildListReport(List<TransactionReport> transList) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        reverse: true,
        shrinkWrap: true,
        itemCount: transList.length,
        itemBuilder: (context, index) {
          return TransactionHistoryCard(
            transactionReport: transList[index],
          );
        },
      ),
    );
  }

  Widget _buildEmptyList() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/transfer.svg',
            width: 0.5 * Constants.deviceWidth,
            height: 0.5 * Constants.deviceHeight,
          ),
          Text(
            'No transaction history',
            style: AppStyles.heading1,
          ),
          SizedBox(
            height: 0.3 * Constants.deviceHeight,
          ),
        ],
      ),
    );
  }
}
