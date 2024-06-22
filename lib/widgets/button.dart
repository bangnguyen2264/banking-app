import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01 * Constants.deviceHeight),
      width: 0.8 * Constants.deviceWidth,
      height: 0.06 * Constants.deviceHeight,
      decoration: BoxDecoration(
        gradient: AppColor.bgColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onPressed?.call();
          },
          borderRadius: BorderRadius.circular(8.0),
          child: Center(
            child: Text(
              title,
              style: AppStyles.button.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
