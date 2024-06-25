import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/widgets/appbar_custom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TransferHistoryScreen extends StatefulWidget {
  const TransferHistoryScreen({super.key});

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
        ],
      ),
    ));
  }
}
