import 'package:flutter/material.dart';

class AppTheme {
  static final themeData = ThemeData(
    fontFamily: 'SF Pro Display',
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF952EE5),
      primary: const Color(0xFF952EE5),
      onPrimary: const Color(0xFFFFFFFF),
      secondary: const Color(0xFF89BFE5),
      surface: const Color(0xFF151A29),
      onSurface: const Color(0xFFFFFFFF),
      surfaceContainer: const Color(0xFF2A3452),
      onSurfaceVariant: const Color(0xFFFFFFFF),
    ),
  );
}
