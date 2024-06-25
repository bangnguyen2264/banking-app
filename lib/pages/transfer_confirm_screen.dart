import 'package:bankingapp/pages/transfer_success_screen.dart';
import 'package:bankingapp/widgets/appbar_custom.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:bankingapp/widgets/button.dart';
import 'package:bankingapp/widgets/cofirm_alert.dart';
import 'package:bankingapp/widgets/form_transfer_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class TransferConfirmScreen extends StatefulWidget {
  const TransferConfirmScreen({super.key});

  @override
  State<TransferConfirmScreen> createState() => _TransferConfirmScreenState();
}

class _TransferConfirmScreenState extends State<TransferConfirmScreen> {
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
              CustomAppbar(title: 'Confirm Transfer'),
              _buildImage(),
              SizedBox(height: 0.02 * Constants.deviceHeight),
              _buildFormDefaultValue('Recipient Name', 'Nguyen Van A'),
              _buildFormDefaultValue('Recipient Account', '12345678912356'),
              _buildFormDefaultValue('Phone Number', '0123456789'),
              _buildFormDefaultValue('Amount', '1,000,000 VND'),
              _buildFormDefaultValue('Description', 'Nguyen Van A send money'),
              SizedBox(height: 0.1 * Constants.deviceHeight),
              CustomButton(
                  title: 'Send',
                  onPressed: () {
                    showConfirmDialog(
                      context,
                      'Do you want to confirm this transaction?',
                      'Transfer',
                      () {
                        Get.to(
                          () => TransferSuccessScreen(),
                        );
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
}
