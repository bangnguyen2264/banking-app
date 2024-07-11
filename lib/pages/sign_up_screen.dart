import 'dart:async';
import 'dart:math';

import 'package:bankingapp/components/error_alert.dart';
import 'package:bankingapp/components/loader_dialog.dart';
import 'package:bankingapp/layouts/authen_layout.dart';
import 'package:bankingapp/pages/sign_in_screen.dart';
import 'package:bankingapp/pages/sign_up_screen.dart';
import 'package:bankingapp/services/auth_service.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/widgets/button.dart';
import 'package:bankingapp/widgets/form_authen_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordcontroller =
      TextEditingController();
  bool confirmTerm = false;
  String errorText = '';
  @override
  Widget build(BuildContext context) {
    return AuthenLayout(title: 'Sign up', mainContent: _buildMainContent());
  }

  Widget _buildMainContent() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.12 * Constants.deviceWidth,
      ),
      child: Stack(
        children: [
          // if (isLoading) LoadingDialog(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeText(),
              _buildLogo(),
              _buildForm(),
              _buildConfirmTerm(),
              CustomButton(
                title: 'Sign Up',
                onPressed: handleSignUp,
              ),
              _buildTextNavigation(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Container(
      margin: EdgeInsets.only(top: 0.02 * Constants.deviceHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to us',
            style: AppStyles.heading1.copyWith(color: AppColor.primaryColor_1),
          ),
          Text(
            'Hello there,  create New account',
            style:
                AppStyles.paragraphSmall.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.02 * Constants.deviceHeight),
      alignment: Alignment.center,
      child: Center(
        child: SvgPicture.asset(
          'assets/images/signup_logo.svg',
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
          controller: nameController,
          labelText: 'Full Name',
        ),
        SizedBox(height: 0.02 * Constants.deviceHeight),
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
        FormAuthen(
          controller: confirmPasswordcontroller,
          labelText: 'Confirm Password',
          isPassword: true,
        ),
        SizedBox(height: 0.01 * Constants.deviceHeight),
      ],
    );
  }

  Widget _buildConfirmTerm() {
    return Container(
      width: 0.8 * Constants.deviceWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: confirmTerm,
            onChanged: (value) {
              setState(() {
                confirmTerm = value!;
              });
            },
            activeColor: AppColor.primaryColor_1,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "By creating an account you agree to our ",
                style: AppStyles.paragraphMedium
                    .copyWith(color: Colors.black), // Default text style
                children: [
                  TextSpan(
                    text: "Terms and Conditions",
                    style: AppStyles.paragraphMediumBold.copyWith(
                      color: AppColor.primaryColor_1,
                    ), // Different color for this part
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextNavigation() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Have an account? ',
            style: AppStyles.paragraphSmall,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => SigninScreen(), transition: Transition.rightToLeft);
              print('Sign In');
            },
            child: Text(
              'Sign in',
              style: AppStyles.paragraphSmall.copyWith(
                color: AppColor.primaryColor_1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> handleSignUp() async {
    print('Sign Up button pressed');
    showLoaderDialog(context);
    bool isSuccess;
    isSuccess = checkValidate();
    print('Validate: $isSuccess');
    if (!isSuccess) {
      Navigator.pop(context);
      showErrorDialog(context, errorText);
      return;
    }
    final body = {
      'fullName': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };
    isSuccess = await AuthService().handleSignUp(body).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        setState(() {
          errorText = 'Sign Up Timeout';
        });
        print('Sign Up Timeout');
        return false;
      },
    );
    Navigator.pop(context);
    if (isSuccess) {
      print('Sign Up Success');
      Get.to(
        () => SigninScreen(),
        transition: Transition.rightToLeft,
      );
    } else {
      setState(() {
        errorText = 'Email already exists';
      });
      showErrorDialog(context, errorText);
    }
  }

  bool checkValidate() {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordcontroller.text.trim();
    print('Check validate');
    if (name.isEmpty) {
      setState(() {
        errorText = 'Full name is required';
      });
      return false;
    }

    if (email.isEmpty) {
      setState(() {
        errorText = 'Email is required';
      });
      return false;
    }
    if (email.isEmail == false) {
      setState(() {
        errorText = 'Email is invalid';
      });
      return false;
    }

    if (password.isEmpty) {
      setState(() {
        errorText = 'Password is required';
      });
      return false;
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        errorText = 'Confirm password is required';
      });
      return false;
    }

    if (password != confirmPassword) {
      setState(() {
        errorText = 'Password and confirm password do not match';
      });
      return false;
    }
    if (!confirmTerm) {
      setState(() {
        errorText = 'Please confirm the terms and conditions';
      });
      return false;
    }
    if (password.length < 8) {
      setState(() {
        errorText = 'Password must be at least 8 characters';
      });
      return false;
    }

    return true;
  }
}
