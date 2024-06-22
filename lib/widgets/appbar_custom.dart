import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final bool centerTitle;
  const CustomAppbar({
    super.key,
    required this.title,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 0.05 * Constants.deviceHeight,
        bottom: 0.013 * Constants.deviceWidth,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          Text(
            title,
            style: AppStyles.heading2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
