import 'package:bankingapp/pages/sign_in_screen.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColor.bgColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(),
            _buildContent(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 0.12 * Constants.deviceHeight,
      width: Constants.deviceWidth,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/components/footer.svg',
            fit: BoxFit.contain,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                margin: EdgeInsets.only(right: 0.1 * Constants.deviceWidth),
                height: 0.08 * Constants.deviceHeight,
                width: 0.08 * Constants.deviceHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    // final apiUrl = dotenv.env['API_URL'] ?? 'API_URL not found';
                    // print('API URL: $apiUrl');
                    Get.to(
                      () => SigninScreen(),
                      transition: Transition.downToUp,
                      curve: Curves.easeInCubic,
                      duration: Duration(milliseconds: 600),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.only(
        left: 0.07 * Constants.deviceWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ready to Start?',
              style: AppStyles.heading1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              )),
          Text(
            'Join millions of satisfied users and take control of your finances today.',
            style: AppStyles.paragraphLarge.copyWith(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 0.5 * Constants.deviceHeight,
      margin: EdgeInsets.only(top: 0.15 * Constants.deviceHeight),
      child: Center(
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/components/onboarding_logo.svg',
                width: 0.87 * Constants.deviceWidth,
                height: 0.38 * Constants.deviceHeight,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0.15 * Constants.deviceHeight,
              left: -0.12 * Constants.deviceWidth,
              child: SvgPicture.asset(
                'assets/components/bubble.svg',
                width: 0.17 * Constants.deviceHeight,
                height: 0.17 * Constants.deviceHeight,
              ),
            ),
            Positioned(
              top: 0.2 * Constants.deviceHeight,
              right: -0.12 * Constants.deviceWidth,
              child: Container(
                width: 0.25 * Constants.deviceHeight,
                height: 0.25 * Constants.deviceHeight,
                child: SvgPicture.asset(
                  'assets/components/bubble.svg',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
