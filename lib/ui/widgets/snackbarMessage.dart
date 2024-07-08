
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/utility/app_colors.dart';

void showSnackBarMessage(BuildContext context, String message,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
         content: Text(message),
         backgroundColor: isError ? Colors.red : AppColors.themeColor,
  ));
}
