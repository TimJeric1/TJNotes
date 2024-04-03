import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

@riverpod
ThemeData appTheme(AppThemeRef ref, Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple, brightness: brightness);
  border({required Color color}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  return ThemeData(
          colorScheme: colorScheme, useMaterial3: true, brightness: brightness)
      .copyWith(
    scaffoldBackgroundColor: colorScheme.surface,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: border(color: colorScheme.surfaceVariant),
      focusedBorder: border(color: colorScheme.inversePrimary),
      errorBorder: border(color: colorScheme.error),
      focusedErrorBorder: border(color: colorScheme.error)
    ),
  );
}
