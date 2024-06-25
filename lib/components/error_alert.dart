import 'package:bankingapp/widgets/button.dart';
import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String content;
  const ErrorAlert({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(content),
      actions: <Widget>[
        CustomButton(
          title: 'Cancel',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
void showErrorDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ErrorAlert(content: content);
    },
  );
}
