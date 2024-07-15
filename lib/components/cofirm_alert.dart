import 'package:bankingapp/styles/colors.dart';
import 'package:bankingapp/styles/text_styles.dart';
import 'package:bankingapp/utils/const.dart';
import 'package:bankingapp/components/button.dart';
import 'package:flutter/material.dart';

class ConfirmAlert extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onConfirm;
  final bool emergency;

  const ConfirmAlert({
    super.key,
    required this.content,
    required this.onConfirm,
    required this.title,
    required this.emergency,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Warning',
        style: AppStyles.paragraphMediumBold
            .copyWith(color: AppColor.primaryColor_1),
      ),
      content: Text(
        content,
        style: AppStyles.paragraphLarge,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          textDirection: !emergency ? TextDirection.ltr : TextDirection.rtl,
          children: [
            Container(
              width: 0.3 * Constants.deviceWidth,
              height: 0.06 * Constants.deviceHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                child: Text(
                  'Cancel',
                  style: AppStyles.button.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.neutral_2,
                  ),
                ),
              ),
            ),
            CustomButton(
              title: title,
              onPressed: onConfirm,
              width: 0.3 * Constants.deviceWidth,
            )
          ],
        ),
      ],
    );
  }
}

void showConfirmDialog(BuildContext context, String content, String title,
    Function() onConfirm, bool emergency) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmAlert(
        content: content,
        onConfirm: onConfirm,
        title: title,
        emergency: emergency,
      );
    },
  );
}
