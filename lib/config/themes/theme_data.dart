import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Color(0xFF181C14),
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3C3D37)),
    appBarTheme: AppBarTheme(color: Color(0xFF3C3D37)),
    primaryColor: Color(0xFF3C3D37),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xFF3C3D37)),
        foregroundColor: WidgetStatePropertyAll(Color(0xFFECDFCC)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF3C3D37), foregroundColor: Color(0xFFECDFCC),),
    textTheme: TextTheme(),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(
        color: Color(0xFFECDFCC),
      ),
      contentTextStyle: TextStyle(color: Color(0xFF040D12)),
    ),
    listTileTheme: ListTileThemeData(
        tileColor: Color(0xFFECDFCC),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        subtitleTextStyle: TextStyle(
          color: Color(0xFF3C3D37),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        iconColor: Colors.white,
        selectedTileColor: Colors.white70));

// 0xFF181C14
// 0xFF3C3D37
// 0xFF697565
// 0xFFECDFCC
