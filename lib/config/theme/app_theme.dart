import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.orange,
  Colors.red,
  Colors.green,
  Colors.deepPurple,
  Colors.yellow
];

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = false,
  });

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      appBarTheme: const AppBarTheme(centerTitle: false));

  AppTheme copyWith({
    bool? isDarkMode
    }) => AppTheme(
      isDarkMode: isDarkMode ?? this.isDarkMode
    );
}
