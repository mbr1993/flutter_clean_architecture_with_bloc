import 'package:flutter/material.dart';

extension TextThemeExtension on TextTheme {
  TextStyle get titleTextStyle => const TextStyle(
        color: Colors.deepPurple,
        fontSize: 44,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subtitleTextStyle => TextStyle(
        color: Colors.deepPurple.shade300,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  TextStyle get textHintStyle => const TextStyle(color: Colors.black45, fontSize: 12);
}
