import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar({
  required String title,
  required String message,
  SnackPosition position = SnackPosition.TOP,
  required Color backgroundColor,
   Color? textColor,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: position,
    backgroundColor: backgroundColor.withOpacity(0.5),
    colorText: textColor ?? Colors.white,
  );
}
