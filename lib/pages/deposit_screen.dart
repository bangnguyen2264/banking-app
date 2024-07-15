import 'package:bankingapp/components/appbar_custom.dart';
import 'package:bankingapp/components/error_alert.dart';
import 'package:bankingapp/components/loader_dialog.dart';
import 'package:bankingapp/pages/transfer_success_screen.dart';
import 'package:bankingapp/services/transaction_service.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/button.dart';
import 'package:bankingapp/components/cofirm_alert.dart';
import 'package:bankingapp/components/form_transfer_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DepositScreen extends StatefulWidget {
  final int accountId;
  const DepositScreen({super.key, required this.accountId});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  TextEditingController amountController = TextEditingController();
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
              title: 'Deposit',
            ),
            _buildImage(),
            _buildFormDeposit(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: SvgPicture.asset(
        'assets/images/transfer.svg',
        width: 0.8 * Constants.deviceWidth,
        height: 0.3 * Constants.deviceHeight,
      ),
    );
  }

  Widget _buildFormDeposit() {
    return Expanded(
      child: Column(
        children: [
          FormInputValue(
              title: 'Amount', controller: amountController, isNumber: true),
          SizedBox(
            height: 20,
          ),
          CustomButton(
              title: 'Deposit',
              onPressed: () {
                if (amountController.text.trim().isEmpty) {
                  showErrorDialog(context, 'Please enter amount to deposit');
                  return;
                } else
                  showConfirmDialog(
                    context,
                    'Do you want to confirm depositing ${amountController.text.trim()} VND into your account? ',
                    "Deposit",
                    _handleDeposit,
                    false,
                  );
              }),
        ],
      ),
    );
  }

  Future<void> _handleDeposit() async {
    showLoaderDialog(context);
    Map<String, dynamic> body = {
      'accountId': widget.accountId,
      'amount': amountController.text.trim(),
    };
    final response = await TransactionService().depositMoney(body);
    Navigator.of(context).pop();
    if (response) {
      Get.offAll(() => TransferSuccessScreen(), transition: Transition.fadeIn);
    } else {
      Navigator.of(context).pop();

      showErrorDialog(context, 'Deposit Failed');
    }
  }
}
