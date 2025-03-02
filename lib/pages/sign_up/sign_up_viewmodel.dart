import 'package:bankingapp/components/error_alert.dart';
import 'package:bankingapp/components/loader_dialog.dart';
import 'package:bankingapp/pages/sign_in/sign_in_screen.dart';
import 'package:bankingapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewmodel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _confirmTerm = false;
  String _errorText = '';

  bool get confirmTerm => _confirmTerm;
  String get errorText => _errorText;

  void setConfirmTerm(bool? value) {
    if (value == null) return;
    _confirmTerm = value;
    notifyListeners();
  }

  Future<void> handleSignUp() async {
    print('Sign Up button pressed');

    if (!_validateInputs()) {
      Get.dialog(ErrorAlert(content: _errorText));
      return;
    }

    Get.dialog(LoadingDialog());
    final body = {
      'fullName': nameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };

    try {
      Get.dialog(LoadingDialog());
      bool isSuccess = await AuthService().handleSignUp(body).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('Sign Up Timeout');
          Get.dialog(ErrorAlert(content: 'Request timeout. Please try again.'));
          return false;
        },
      );
      Get.back();
      if (isSuccess) {
        print('Sign Up Success');
        Get.offAll(() => SigninScreen(), transition: Transition.rightToLeft);
      } else {
        _setError('Email already exists');
      }
    } catch (e) {
      _setError('Something went wrong. Please try again.');
    }
  }

  bool _validateInputs() {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty) return _setError('Full name is required');
    if (email.isEmpty) return _setError('Email is required');
    if (!email.isEmail) return _setError('Email is invalid');
    if (password.isEmpty) return _setError('Password is required');
    if (confirmPassword.isEmpty) {
      return _setError('Confirm password is required');
    }
    if (password != confirmPassword) return _setError('Passwords do not match');
    if (!_confirmTerm) {
      return _setError('Please accept the terms and conditions');
    }
    if (password.length < 8) {
      return _setError('Password must be at least 8 characters');
    }

    return true;
  }

  bool _setError(String message) {
    _errorText = message;
    notifyListeners();
    return false;
  }
}
