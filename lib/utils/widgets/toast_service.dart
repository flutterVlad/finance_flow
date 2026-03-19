import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/utils/theme.dart';

enum ToastStatus { success, error, warning }

abstract class ToastService {
  static Future<bool?> showToast({
    String? message,
    ToastStatus status = .success,
  }) async {
    return await Fluttertoast.showToast(
      gravity: .TOP,
      msg: message ?? 'Message',
      backgroundColor: switch (status) {
        .success => Colors.green,
        .error => AppColors.error,
        .warning => Colors.orange,
      },
      textColor: AppColors.onPrimary,
    );
  }
}
