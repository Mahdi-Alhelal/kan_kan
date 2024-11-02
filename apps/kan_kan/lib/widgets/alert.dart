import 'package:flutter/material.dart';

alert(
    {required BuildContext context,
    required String msg,
    required bool isCompleted}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isCompleted == true ? Colors.green : Colors.red,
      content: Center(child: Text(msg)),
    ),
  );
}
