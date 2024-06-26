import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
            padding:
                EdgeInsets.symmetric(horizontal: 0.02 * Constants.deviceWidth),
            width: 0.8 * Constants.deviceWidth,
            height: 0.05 * Constants.deviceHeight,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColor.neutral_5,
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 0.75 * Constants.deviceWidth,
                ),
                child: TextField(
                  maxLines: 1,
                  controller: controller,
                  keyboardType:
                      isNumber ? TextInputType.number : TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  inputFormatters: isNumber
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ]
                      : null,
                  style: AppStyles.paragraphSmallBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
