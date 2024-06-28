import 'package:bankingapp/components/error_alert.dart';
import 'package:bankingapp/models/accounts.dart';
import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/services/account_service.dart';
import 'package:bankingapp/services/user_service.dart';
import 'package:bankingapp/widgets/appbar_custom.dart';
import 'package:bankingapp/pages/transfer_confirm_screen.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:bankingapp/widgets/button.dart';
import 'package:bankingapp/widgets/form_transfer_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TransferScreen extends StatefulWidget {
  final User? fromAccount;
  const TransferScreen({super.key, required this.fromAccount});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController accountReceivingController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
  late User? recipient;
  bool isLoading = false;
  String errorText = '';
  @override
  void initState() {
    super.initState();
    if (widget.fromAccount != null) {
      discriptionController.text =
          '${widget.fromAccount!.fullName} transferred the money to you.';
    }
  }

  @override
  void dispose() {
    accountReceivingController.dispose();
    amountController.dispose();
    discriptionController.dispose();
    super.dispose();
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
              CustomAppbar(title: 'Transfer'),
              _buildImage(),
              _buildFormDefaultValue('Account',
                  widget.fromAccount!.accountNumber[0].accountNumber),
              _buildAvailableBalanceText(),
              FormInputValue(
                title: 'To Account',
                controller: accountReceivingController,
                isNumber: true,
              ),
              FormInputValue(
                title: 'Choose Amount',
                controller: amountController,
                isNumber: true,
              ),
              FormInputValue(
                title: 'Description',
                controller: discriptionController,
              ),
              CustomButton(
                title: 'Confirm',
                onPressed: () async {
                  if (validate()) {
                    if (!await getRecipient()) {
                      showErrorDialog(
                        context,
                        'The recipient account number is not valid. Please try again',
                      );
                      return;
                    }
                    Get.to(
                      () => TransferConfirmScreen(
                        fromAccount:
                            widget.fromAccount!.accountNumber[0].accountNumber,
                        toAccount: accountReceivingController.text,
                        amount: amountController.text,
                        description: discriptionController.text,
                      ),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 500),
                    );
                  } else {
                    showErrorDialog(
                      context,
                      errorText,
                    );
                  }
                },
              ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 0.01 * Constants.deviceWidth),
            child: Text(
              title,
              style:
                  AppStyles.paragraphSmall.copyWith(color: AppColor.neutral_3),
            ),
          ),
          SizedBox(
            height: 0.01 * Constants.deviceHeight,
          ),
          Container(
            padding: EdgeInsets.only(left: 0.02 * Constants.deviceWidth),
            width: 0.8 * Constants.deviceWidth,
            height: 0.05 * Constants.deviceHeight,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColor.neutral_5,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              value,
              style: AppStyles.paragraphMediumBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableBalanceText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.01 * Constants.deviceHeight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Available Balance:',
            style: AppStyles.paragraphSmall.copyWith(color: AppColor.neutral_3),
          ),
          SizedBox(
            height: 0.01 * Constants.deviceHeight,
          ),
          Text(
            formatMoney(widget.fromAccount!.accountNumber[0].balance),
            style: AppStyles.paragraphSmallBold,
          ),
        ],
      ),
    );
  }

  bool validate() {
    if (accountReceivingController.text.trim().isEmpty) {
      setState(() {
        errorText = 'Please enter the recipient account number';
      });
      return false;
    }
    if (amountController.text.trim().isEmpty) {
      setState(() {
        errorText = 'Please enter the amount';
      });
      return false;
    }
    if (int.tryParse(amountController.text.trim())! >
        widget.fromAccount!.accountNumber[0].balance) {
      setState(() {
        errorText = 'The amount must be less than the available balance';
      });
      return false;
    }
    if (discriptionController.text.isEmpty) {
      setState(() {
        errorText = 'Please enter the description';
      });
      return false;
    }
    if (accountReceivingController.text ==
        widget.fromAccount!.accountNumber[0].accountNumber) {
      setState(() {
        errorText = 'You cannot transfer money to yourself';
      });
      return false;
    }
    return true;
  }

  Future<bool> getRecipient() async {
    User? user = await UserService()
        .getByAccountNumber(accountReceivingController.text)
        .timeout(Duration(seconds: 10), onTimeout: () {
      showErrorDialog(context, 'Request timeout. Please try again');
    });
    if (user == null) {
      setState(() {
        errorText =
            'The recipient account number is not valid. Please try again';
      });
    }

    return user != null;
  }
}
