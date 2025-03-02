import 'package:bankingapp/layouts/authen_layout.dart';
import 'package:bankingapp/pages/sign_in/sign_in_viewmodel.dart';
import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/button.dart';
import 'package:bankingapp/components/form_authen_input.dart';
import 'package:bankingapp/pages/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: Consumer<SignInViewModel>(
        builder: (context, viewModel, child) {
          return AuthenLayout(
            title: 'Sign in',
            mainContent: _buildMainContent(viewModel),
          );
        },
      ),
    );
  }

  Widget _buildMainContent(SignInViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.12 * Constants.deviceWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeText(),
          _buildLogo(),
          _buildForm(viewModel),
          _buildForgotPassword(),
          CustomButton(
            title: viewModel.isLoading ? 'Loading...' : 'Sign in',
            onPressed: viewModel.isLoading
                ? null
                : () async {
                    await viewModel.handleSignIn();
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

  Widget _buildForm(SignInViewModel viewModel) {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          'Forgot password',
          'This feature is in development, will be available in the next version',
        );
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Forgot password?',
          style: AppStyles.paragraphSmall.copyWith(
            color: AppColor.primaryColor_1,
          ),
        ),
      ),
    );
  }

  Widget _buildTextNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: AppStyles.paragraphSmall,
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => SignupScreen(), transition: Transition.rightToLeft);
          },
          child: Text(
            'Sign up',
            style: AppStyles.paragraphSmall.copyWith(
              color: AppColor.primaryColor_1,
            ),
          ),
        ),
      ],
    );
  }
}
