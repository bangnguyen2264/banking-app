import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Function()? onPressed;
  CustomButton({
    Key? key,
    required this.title,
    this.onPressed,
    double? width,
    double? height,
  })  : width = width ?? 0.8 * Constants.deviceWidth,
        height = height ?? 0.06 * Constants.deviceHeight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01 * Constants.deviceHeight),
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: AppColor.bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onPressed?.call();
          },
          borderRadius: BorderRadius.circular(15),
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
