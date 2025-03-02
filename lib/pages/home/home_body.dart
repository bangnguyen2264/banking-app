import 'package:auto_size_text/auto_size_text.dart';
import 'package:bankingapp/pages/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:bankingapp/components/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBody extends StatelessWidget {
  final User user;

  const HomeBody({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.09 * Constants.deviceWidth,
      ).copyWith(top: 0.1 * Constants.deviceHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGoodmorning(user.fullName),
          _buildAccountCard(user),
          _buildGridMenu(user),
        ],
      ),
    );
  }

  Widget _buildGoodmorning(String name) {
    return Container(
      width: 0.7 * Constants.deviceWidth,
      child: Text(
        'Good Morning, $name!',
        style: TextStyle(
          fontSize: 32,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccountCard(User user) {
    return Container(
      width: 0.8 * Constants.deviceWidth,
      height: 0.3 * Constants.deviceHeight,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/components/card_home.svg',
            width: 0.8 * Constants.deviceWidth,
            height: 0.3 * Constants.deviceHeight,
            fit: BoxFit.cover,
          ),
          user.account.accountNumber.isNotEmpty
              ? _buildAccountDetails(user)
              : _buildCreateAccountButton(),
        ],
      ),
    );
  }

  Widget _buildAccountDetails(User user) {
    return Container(
      width: 0.8 * Constants.deviceWidth,
      height: 0.3 * Constants.deviceHeight,
      padding: EdgeInsets.symmetric(
        horizontal: 0.09 * Constants.deviceWidth,
        vertical: 0.06 * Constants.deviceHeight,
      ).copyWith(bottom: 0.075 * Constants.deviceHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            user.fullName,
            style: AppStyles.heading1.copyWith(color: Colors.white),
            maxLines: 2,
          ),
          AutoSizeText(
            hideNumberAccount(user.account.accountNumber),
            style: AppStyles.paragraphLarge.copyWith(color: Colors.white),
            maxLines: 2,
          ),
          AutoSizeText(
            formatMoney(user.account.balance),
            style: AppStyles.paragraphLargeBold.copyWith(color: Colors.white),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return Center(
      child: CustomButton(
        title: 'Create Account',
        onPressed: () {},
        width: 0.35 * Constants.deviceWidth,
        height: 0.07 * Constants.deviceHeight,
      ),
    );
  }

  Widget _buildGridMenu(User user) {
    return Container(
      margin: EdgeInsets.only(top: 0.01 * Constants.deviceHeight),
      width: Constants.deviceWidth,
      height: 0.3 * Constants.deviceHeight,
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          _buildMenuItem(
            'assets/components/account_card.svg',
            'Account \nand Card',
            () {
              Get.to(() => AccountScreen());
            },
          ),
          _buildMenuItem(
            'assets/components/transfer.svg',
            'Transfer',
            () {},
          ),
          _buildMenuItem('assets/components/trans_history.svg',
              'Transaction history', () {}),
          _buildMenuItem(
            'assets/icons/deposit.svg',
            'Deposit',
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(0.02 * Constants.deviceWidth),
        width: 0.1 * Constants.deviceHeight,
        height: 0.1 * Constants.deviceHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon, width: 0.07 * Constants.deviceWidth),
            AutoSizeText(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
