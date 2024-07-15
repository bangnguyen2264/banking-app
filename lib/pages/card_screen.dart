import 'package:auto_size_text/auto_size_text.dart';
import 'package:bankingapp/components/loader_dialog.dart';
import 'package:bankingapp/models/accounts.dart';
import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/services/account_service.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:bankingapp/components/appbar_custom.dart';
import 'package:bankingapp/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CardScreen extends StatefulWidget {
  final User user;
  const CardScreen({super.key, required this.user});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.1 * Constants.deviceWidth,
        ),
        child: Column(
          children: [
            CustomAppbar(title: 'Card'),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.user.accountNumber.length,
                  itemBuilder: (context, index) {
                    return _buildCard(widget.user.accountNumber[index]);
                  }),
            ),
            CustomButton(
                title: 'Add Card',
                onPressed: () {
                  final response = AccountService().createAccount(widget.user.id);
                  showLoaderDialog(context);
                  response.then((value) {
                    Navigator.pop(context);
                    if (value != null) {
                      setState(() {
                        widget.user.accountNumber.add(value);
                      });
                    }
                  });

                }),
            SizedBox(height: 0.025 * Constants.deviceHeight)
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Account account) {
    return Center(
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/components/card.svg',
            width: 0.8 * Constants.deviceWidth,
            height: 0.3 * Constants.deviceHeight,
            fit: BoxFit.cover,
          ),
          Container(
            width: 0.8 * Constants.deviceWidth,
            height: 0.3 * Constants.deviceHeight,
            padding: EdgeInsets.symmetric(
              horizontal: 0.09 * Constants.deviceWidth,
              vertical: 0.05 * Constants.deviceHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 0.35 * Constants.deviceWidth,
                  child: AutoSizeText(
                    widget.user.fullName,
                    style: AppStyles.heading1.copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 0.025 * Constants.deviceHeight),
                Container(
                  width: 0.35 * Constants.deviceWidth,
                  child: AutoSizeText(
                    account.accountNumber,
                    style: AppStyles.heading2.copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 0.01 * Constants.deviceHeight),
                Container(
                  width: 0.35 * Constants.deviceWidth,
                  child: AutoSizeText(
                    formatMoney(account.balance),
                    style: AppStyles.paragraphLargeBold.copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
