import 'package:flutter/material.dart';

// Color appBaseColor = const Color(0xffFDB200);
// Color shade200 = const Color(0xffFDB200);
// Color shade300 = const Color(0xffFDB200);
// Color shade700 = const Color(0xffFDB200);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.white,
    inversePrimary: Colors.grey.shade700,
  ),
);
