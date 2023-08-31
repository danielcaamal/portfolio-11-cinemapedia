import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2862f5)),
        useMaterial3: true,
      );
}
