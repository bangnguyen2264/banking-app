import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/pages/transfer_success_screen.dart';
import 'package:bankingapp/services/account_service.dart';
import 'package:bankingapp/services/transaction_service.dart';
import 'package:bankingapp/services/user_service.dart';
import 'package:bankingapp/widgets/appbar_custom.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:bankingapp/widgets/button.dart';
import 'package:bankingapp/widgets/cofirm_alert.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TransferConfirmScreen extends StatefulWidget {
  final String fromAccount;
  final String toAccount;
  final String amount;
  final String description;
  const TransferConfirmScreen({
    super.key,
    required this.toAccount,
    required this.amount,
    required this.description,
    required this.fromAccount,
  });

  @override
  State<TransferConfirmScreen> createState() => _TransferConfirmScreenState();
}

class _TransferConfirmScreenState extends State<TransferConfirmScreen> {
  late String fromAccountId;
  User? recipient;
  @override
  void initState() {
    super.initState();
    getAccountId();
    getRecipient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.1 * Constants.deviceWidth,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppbar(title: 'Confirm Transfer'),
              _buildImage(),
              SizedBox(height: 0.02 * Constants.deviceHeight),
              _buildFormDefaultValue(
                'Recipient Name',
                recipient?.fullName == ''
                    ? 'No information'
                    : recipient?.fullName ?? 'No information',
              ),
              _buildFormDefaultValue(
                'Recipient Account',
                widget.toAccount == '' ? 'No information' : widget.toAccount,
              ),
              _buildFormDefaultValue(
                'Phone Number',
                recipient?.phoneNumber == ''
                    ? 'No information'
                    : recipient?.phoneNumber ?? 'No information',
              ),
              _buildFormDefaultValue(
                  'Amount', formatMoney(int.parse(widget.amount))),
              _buildFormDefaultValue('Description', widget.description),
              SizedBox(height: 0.1 * Constants.deviceHeight),
              CustomButton(
                  title: 'Send',
                  onPressed: () {
                    showConfirmDialog(
                      context,
                      'Do you want to confirm this transaction?',
                      'Transfer',
                      () async {
                        getAccountId();
                        final body = {
                          "toAccountNumber": widget.toAccount,
                          "amount": widget.amount,
                          "description": widget.description,
                          "accountId": fromAccountId,
                        };
                        final isSuccess =
                            TransactionService().transferMoney(body);

                        if (await isSuccess) {
                          Get.to(
                            () => TransferSuccessScreen(),
                          );
                        }
                      },
                      false,
                    );
                  }),
            ],
          ),
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

  Widget _buildFormDefaultValue(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01 * Constants.deviceHeight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: AppStyles.paragraphLarge,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppStyles.paragraphLargeBold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getAccountId() async {
    final account =
        await AccountService().getAccountByNumber(widget.fromAccount);
    setState(() {
      fromAccountId = account!.id.toString();
    });
  }

  Future<void> getRecipient() async {
    User? user = await UserService().getByAccountNumber(widget.toAccount);

    setState(() {
      recipient = user;
    });
  }
}
