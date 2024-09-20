import 'package:flutter/material.dart';

class BaseTextSnackBar {
  static SnackBar create({
    required String text,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    return SnackBar(
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Text(
        text.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 16,
        ),
      ),
    );
  }
}
