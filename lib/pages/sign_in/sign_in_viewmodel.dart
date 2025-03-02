import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bankingapp/components/loader_dialog.dart';
import 'package:bankingapp/components/error_alert.dart';
import 'package:bankingapp/services/auth_service.dart';
import 'package:bankingapp/components/nav_bar.dart';

class SignInViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> handleSignIn() async {
    setLoading(true);
    Get.dialog(LoadingDialog());

    final body = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    bool isSuccess = await AuthService().handleSignIn(body).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        return false;
      },
    );

    setLoading(false);
    Get.back();

    if (isSuccess) {
      Get.offAll(() => NavBar(), transition: Transition.rightToLeft);
    } else {
      Get.dialog(
        ErrorAlert(content: 'Email or password is incorrect'),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
