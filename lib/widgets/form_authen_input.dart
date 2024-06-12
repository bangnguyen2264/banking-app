import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:flutter/material.dart';

class FormAuthen extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final bool isPhone;
  final String labelText;

  // final bool isError;

  const FormAuthen({
    required this.controller,
    this.isPassword = false,
    this.isPhone = false,
    required this.labelText,

    // this.isError = false,
  });

  @override
  State<FormAuthen> createState() => _FormAuthenState();
}

class _FormAuthenState extends State<FormAuthen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.76 * Constants.deviceWidth,
      height: 0.05 * Constants.deviceHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: AppColor.neutral_4,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Align(
          alignment: Alignment.center,
          child: TextField(
            keyboardType:
                widget.isPhone ? TextInputType.number : TextInputType.text,
            controller: widget.controller,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              labelText: widget.labelText,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
