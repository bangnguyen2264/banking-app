import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bankingapp/models/accounts.dart';
import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/pages/account_screen.dart';
import 'package:bankingapp/pages/deposit_screen.dart';
import 'package:bankingapp/pages/transfer_history_screen.dart';
import 'package:bankingapp/pages/transfer_screen.dart';
import 'package:bankingapp/services/account_service.dart';
import 'package:bankingapp/services/user_service.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/utils/format_string.dart';
import 'package:bankingapp/widgets/button.dart';
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
  late Future<User?> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = UserService().getMe();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureUser = UserService().getMe();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<User?>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor_1,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final user = snapshot.data;
            if (user == null) {
              return Center(
                child: Text('User not found'),
              );
            }
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
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
              ),
            );
          },
        ),
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
      child: Center(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/components/card_home.svg',
              width: 0.8 * Constants.deviceWidth,
              height: 0.3 * Constants.deviceHeight,
              fit: BoxFit.cover,
            ),
            user.accountNumber.isNotEmpty
                ? Container(
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
                            user.fullName,
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
                            hideNumberAccount(
                                user.accountNumber[0].accountNumber),
                            style: AppStyles.paragraphLarge.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 0.35 * Constants.deviceWidth,
                          child: AutoSizeText(
                            formatMoney(user.accountNumber[0].balance),
                            style: AppStyles.paragraphLargeBold.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  )
                : BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      width: 0.8 * Constants.deviceWidth,
                      height: 0.3 * Constants.deviceHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.13),
                          width: 1,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Center(
                        child: CustomButton(
                          title: 'Create Account',
                          onPressed: () {
                            AccountService().createAccount(user.id);
                            _refresh();
                          },
                          width: 0.35 * Constants.deviceWidth,
                          height: 0.07 * Constants.deviceHeight,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
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
            icon: 'assets/components/account_card.svg',
            title: 'Account \nand Card',
            onTap: () {
              Get.to(
                () => AccountScreen(user: user),
                transition: Transition.fadeIn,
              );
              print('Account and Card');
            },
          ),
          _buildMenuItem(
            icon: 'assets/components/transfer.svg',
            title: 'Transfer',
            onTap: () {
              Get.to(
                () => TransferScreen(
                  fromAccount: user,
                ),
                transition: Transition.fadeIn,
              );
              print('Transfer');
            },
          ),
          _buildMenuItem(
            icon: 'assets/components/trans_history.svg',
            title: 'Transaction history',
            onTap: () {
              Get.to(
                () => TransferHistoryScreen(
                  accountId: user.accountNumber[0].id,
                ),
                transition: Transition.fadeIn,
              );
              print('Transaction history');
            },
          ),
          _buildMenuItem(
            icon: 'assets/icons/deposit.svg',
            title: 'Deposit',
            onTap: () {
              print('Deposit');
              Get.to(
                () => DepositScreen(
                  accountId: user.accountNumber[0].id,
                ),
                transition: Transition.fadeIn,
              );
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
