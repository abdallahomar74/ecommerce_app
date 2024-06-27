import 'package:flutter/material.dart';

String? token;
String? currentPassword;
void showSnackBarItem(
      BuildContext context, String message, bool forSuccessOrFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: forSuccessOrFailure == true ? Colors.green : Colors.red,
    ));
  }
