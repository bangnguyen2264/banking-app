import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/button.dart';
import 'package:bankingapp/components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TransferSuccessScreen extends StatelessWidget {
  const TransferSuccessScreen({super.key});

  @override   
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.1 * Constants.deviceWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 0.2 * Constants.deviceHeight),
              child: SvgPicture.asset(
                'assets/components/succes_transfer.svg',
                width: 0.5 * Constants.deviceWidth,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.05 * Constants.deviceHeight),
              child: Text(
                'Transfer Success',
                style: AppStyles.heading1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.05 * Constants.deviceHeight),
              child: Text(
                'Your transfer has been successfully processed',
                style: AppStyles.paragraphSmall,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 0.12 * Constants.deviceHeight),
            Container(
              margin: EdgeInsets.only(top: 0.1 * Constants.deviceHeight),
              child: CustomButton(
                title: 'Back to Home',
                onPressed: () {
                  Get.offAll(() => NavBar(), transition: Transition.fadeIn);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
