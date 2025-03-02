import 'package:bankingapp/pages/sign_in/sign_in_screen.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/appbar_custom.dart';
import 'package:bankingapp/components/cofirm_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 0.1 * Constants.deviceWidth,
          right: 0.05 * Constants.deviceWidth,
        ),
        child: Column(
          children: [
            CustomAppbar(
              title: 'Settings',
              hideIconLeading: true,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      'Change Password',
                      style: AppStyles.paragraphMediumBold,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.snackbar('Forgot password',
                          'This feature is in development, will be available in the next version');
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Customer Support',
                      style: AppStyles.paragraphMediumBold,
                    ),
                    trailing: Text('19008989'),
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: AppStyles.paragraphMediumBold,
                    ),
                    onTap: () {
                      showConfirmDialog(
                        context,
                        'Do you want to log out of this account?',
                        'Log out',
                        handleLogout,
                        true,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(() => const SigninScreen(), transition: Transition.native);
  }
}
