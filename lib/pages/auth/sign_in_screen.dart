import 'package:bankingapp/components/error_alert.dart';
import 'package:bankingapp/components/loader_dialog.dart';
import 'package:bankingapp/layouts/authen_layout.dart';
import 'package:bankingapp/pages/auth/sign_up_screen.dart';
import 'package:bankingapp/services/auth_service.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/button.dart';
import 'package:bankingapp/components/form_authen_input.dart';
import 'package:bankingapp/components/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AuthenLayout(title: 'Sign in', mainContent: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.12 * Constants.deviceWidth,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeText(),
          _buildLogo(),
          _buildForm(),
          _buildForgotPassword(),
          CustomButton(
            title: 'Sign in',
            onPressed: () async {
              print('Sign In button pressed');
              setState(() {
                isLoading = true;
              });
              showLoaderDialog(context);
              final body = {
                'email': emailController.text,
                'password': passwordController.text,
              };

              bool isSuccess = await AuthService().handleSignIn(body).timeout(
                Duration(seconds: 10),
                onTimeout: () {
                  print('Sign In Timeout');
                  return false;
                },
              );
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).pop();

              if (isSuccess) {
                print('Sign In Success');
                Get.offAll(
                  () => NavBar(),
                  transition: Transition.rightToLeft,
                );
              } else {
                showErrorDialog(context, 'Sign In Failed');
                print('Sign In Failed');
              }
            },
          ),
          _buildTextNavigation(),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Container(
      margin: EdgeInsets.only(top: 0.03 * Constants.deviceHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: AppStyles.heading1.copyWith(color: AppColor.primaryColor_1),
          ),
          Text(
            'Hello there, sign in to continue',
            style:
                AppStyles.paragraphSmall.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.03 * Constants.deviceHeight),
      alignment: Alignment.center,
      child: Center(
        child: SvgPicture.asset(
          'assets/images/signin_logo.svg',
          width: 0.5 * Constants.deviceWidth,
          height: 0.2 * Constants.deviceHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        FormAuthen(
          controller: emailController,
          labelText: 'Email',
        ),
        SizedBox(height: 0.02 * Constants.deviceHeight),
        FormAuthen(
          controller: passwordController,
          labelText: 'Password',
          isPassword: true,
        ),
        SizedBox(height: 0.02 * Constants.deviceHeight),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
        Get.snackbar('Forgot password',
            'This feature is in development, will be available in the next version');
        print('Forgot password');
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Forgot password ?',
              style: AppStyles.paragraphSmall.copyWith(
                color: AppColor.primaryColor_1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextNavigation() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account ? ',
            style: AppStyles.paragraphSmall,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => SignupScreen(), transition: Transition.rightToLeft);
              print('Sign up');
            },
            child: Text(
              'Sign up',
              style: AppStyles.paragraphSmall.copyWith(
                color: AppColor.primaryColor_1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
