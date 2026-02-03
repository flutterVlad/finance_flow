import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/utils/theme.dart';

abstract class ToastService {
  static Future<bool?> showToast({String? message, bool? success}) async {
    return await Fluttertoast.showToast(
      gravity: .TOP,
      msg: message ?? 'Message',
      backgroundColor: success ?? true ? Colors.green : AppColors.error,
      textColor: AppColors.onPrimary,
    );
  }
}
