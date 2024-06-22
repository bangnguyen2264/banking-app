import 'package:bankingapp/widgets/appbar_custom.dart';
import 'package:bankingapp/pages/transfer_confirm_screen.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:bankingapp/widgets/button.dart';
import 'package:bankingapp/widgets/form_transfer_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController accountReceivingController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();
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
              _buildFormDefaultValue('Account', '12345678912356'),
              _buildAvailableBalanceText(),
              FormInputValue(
                title: 'To Account',
                controller: accountReceivingController,
                isNumber: true,
              ),
              FormInputValue(
                title: 'Choose Amount',
                controller: amountController,
              ),
              FormInputValue(
                title: 'Description',
                controller: discriptionController,
                isNumber: true,
              ),
              CustomButton(
                title: 'Confirm',
                onPressed: () {
                  Get.to(
                    () => TransferConfirmScreen(),
                    transition: Transition.rightToLeftWithFade,
                    duration: Duration(milliseconds: 500),
                  );
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
            formatMoney(1000000),
            style: AppStyles.paragraphSmallBold,
          ),
        ],
      ),
    );
  }
}
