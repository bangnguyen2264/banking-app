import 'package:flutter/material.dart';
import 'package:bankingapp/styles/colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor_1),
        ),
      ),
    );
  }
}


void showLoaderDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false, // Prevent dialog from being closed
        child: LoadingDialog(),
      );
    },
  );
}