import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInputValue extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isNumber;

  FormInputValue({
    required this.title,
    required this.controller,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.01 * Constants.deviceHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 0.01 * Constants.deviceWidth),
            child: Text(title, style: AppStyles.paragraphSmall),
          ),
          SizedBox(
            height: 0.01 * Constants.deviceHeight,
          ),
          Container(
            padding: EdgeInsets.all(0.02 * Constants.deviceWidth),
            width: 0.8 * Constants.deviceWidth,
            height: 0.05 * Constants.deviceHeight,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColor.neutral_5,
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
                controller: controller,
                keyboardType:
                    isNumber ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: controller.text.isEmpty
                      ? null
                      : IconButton(
                          icon: Icon(
                            Icons.clear_rounded,
                            color: AppColor.neutral_3,
                          ),
                          onPressed: () {
                            controller.clear();
                          },
                        ),
                ),
                inputFormatters:
                    isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
                style: AppStyles.paragraphMedium),
          ),
        ],
      ),
    );
  }
}
