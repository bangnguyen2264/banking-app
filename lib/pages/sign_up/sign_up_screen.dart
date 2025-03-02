import 'package:bankingapp/layouts/authen_layout.dart';
import 'package:bankingapp/pages/sign_in/sign_in_screen.dart';
import 'package:bankingapp/pages/sign_up/sign_up_viewmodel.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/button.dart';
import 'package:bankingapp/components/form_authen_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewmodel(),
      child: Consumer<SignUpViewmodel>(
        builder: (context, viewModel, child) {
          return AuthenLayout(
            title: 'Sign up',
            mainContent: _buildMainContent(viewModel),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(SignUpViewmodel viewModel) {
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
              _buildForm(viewModel),
              _buildConfirmTerm(viewModel),
              CustomButton(
                title: 'Sign Up',
                onPressed: () => viewModel.handleSignUp(),
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

  Widget _buildForm(SignUpViewmodel viewModel) {
    return Column(
      children: [
        FormAuthen(
          controller: viewModel.nameController,
          labelText: 'Full Name',
        ),
        SizedBox(height: 0.02 * Constants.deviceHeight),
        FormAuthen(
          controller: viewModel.emailController,
          labelText: 'Email',
        ),
        SizedBox(height: 0.02 * Constants.deviceHeight),
        FormAuthen(
          controller: viewModel.passwordController,
          labelText: 'Password',
          isPassword: true,
        ),
        SizedBox(height: 0.02 * Constants.deviceHeight),
        FormAuthen(
          controller: viewModel.confirmPasswordController,
          labelText: 'Confirm Password',
          isPassword: true,
        ),
        SizedBox(height: 0.01 * Constants.deviceHeight),
      ],
    );
  }

  Widget _buildConfirmTerm(SignUpViewmodel viewModel) {
    return Container(
      width: 0.8 * Constants.deviceWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: viewModel.confirmTerm,
            onChanged: viewModel.setConfirmTerm,
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
}
