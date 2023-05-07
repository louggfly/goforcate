import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goforcate_app/widgets/big_text.dart';

import '../utils/dimensions.dart';

void ShowErrorSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message,
      titleText:
          BigText(text: title, color: Colors.white, size: Dimension.gap15),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 1));
}

void ShowSuccessSnackBar(String message,
    {bool isSuccess = true, String title = "Success"}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        color: Colors.white,
        size: Dimension.gap15,
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.greenAccent,
      duration: const Duration(seconds: 1));
}
