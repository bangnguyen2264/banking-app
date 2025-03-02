import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bankingapp/models/user.dart';
import 'package:bankingapp/services/user_service.dart';

class AccountViewModel extends ChangeNotifier {
  User? user;

  bool isHide = true;
  bool editMode = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? errorText;

  AccountViewModel() {
    _init();
  }

  Future<void> _init() async {
    user = await UserService().getMe();
    if (user != null) {
      fullNameController.text = user!.fullName;
      phoneNumberController.text = user!.phone ?? '';
      emailController.text = user!.email;
    }
    notifyListeners();
  }

  void toggleHide() {
    isHide = !isHide;
    notifyListeners();
  }

  void toggleEditMode() {
    editMode = !editMode;
    notifyListeners();
  }

  Future<void> handleUpdateInfo() async {
    if (user == null) return;

    final response = await UserService().update(user!.id, {
      'fullName': fullNameController.text.trim(),
      'phoneNumber': phoneNumberController.text.trim(),
      'email': emailController.text.trim(),
    });

    if (response) {
      user!.fullName = fullNameController.text.trim();
      user!.phone = phoneNumberController.text.trim();
      user!.email = emailController.text.trim();
      Get.snackbar('Success', 'Update information successfully');
    } else {
      Get.snackbar('Error', 'Update information failed');
    }

    editMode = false;
    notifyListeners();
  }

  bool checkValidate() {
    if (fullNameController.text.trim().isEmpty ||
        phoneNumberController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty) {
      errorText = 'Please fill all fields';
      notifyListeners();
      return false;
    }
    if (!emailController.text.trim().isEmail) {
      errorText = 'Email is invalid';
      notifyListeners();
      return false;
    }
    return true;
  }
}
