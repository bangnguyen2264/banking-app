import 'package:auto_size_text/auto_size_text.dart';
import 'package:bankingapp/pages/account_screen.dart';
import 'package:bankingapp/pages/transfer_screen.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.09 * Constants.deviceWidth,
        ).copyWith(top: 0.1 * Constants.deviceHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGoodmorning(),
            _buildAccountCard(),
            _buildGridMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoodmorning() {
    return Container(
      width: 0.7 * Constants.deviceWidth,
      child: Text(
        'Good Morning, George!',
        style: TextStyle(
          fontSize: 32,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccountCard() {
    return Center(
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/components/card_home.svg',
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
                    'GEORGE FLOYD',
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
                    hideNumberAccount('12345678912356'),
                    style: AppStyles.paragraphLarge.copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 0.35 * Constants.deviceWidth,
                  child: AutoSizeText(
                    formatMoney(1000000),
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

  Widget _buildGridMenu() {
    return Container(
      margin: EdgeInsets.only(top: 0.01 * Constants.deviceHeight),
      width: Constants.deviceWidth,
      height: 0.3 * Constants.deviceHeight,
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          _buildMenuItem(
            icon: 'assets/components/account_card.svg',
            title: 'Account \nand Card',
            onTap: () {
              Get.to(() => AccountScreen(), transition: Transition.fadeIn);
              print('Account and Card');
            },
          ),
          _buildMenuItem(
            icon: 'assets/components/transfer.svg',
            title: 'Transfer',
            onTap: () {
              Get.to(() => TransferScreen(), transition: Transition.fadeIn);
              print('Transfer');
            },
          ),
          _buildMenuItem(
            icon: 'assets/components/trans_history.svg',
            title: 'Transaction history',
            onTap: () {
              print('Transaction history');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(0.02 * Constants.deviceWidth),
        width: 0.1 * Constants.deviceHeight,
        height: 0.1 * Constants.deviceHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                icon,
                width: 0.07 * Constants.deviceWidth,
                height: 0.07 * Constants.deviceWidth,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                title,
                textAlign: TextAlign.center,
                style: AppStyles.paragraphSmall.copyWith(
                  color: AppColor.neutral_3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
