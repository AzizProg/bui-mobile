import 'package:flutter/material.dart';

import 'package:test_mobile/src/shared/enums/snackbar_message_type.dart';

class CustomSnackbar extends SnackBar {
   CustomSnackbar(
      {required this.message, required this.messageType, super.key})
      : super(
          content: Text(message),
          backgroundColor:
              messageType == MessageType.error ? Colors.red : Colors.green,
          behavior: SnackBarBehavior.floating,
          elevation: 10,
        );
  final String message;
  final MessageType messageType;
}
