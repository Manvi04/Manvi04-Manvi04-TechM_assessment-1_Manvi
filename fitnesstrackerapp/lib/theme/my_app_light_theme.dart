import 'package:flutter/material.dart';

final ThemeData myAppLightTheme = ThemeData().copyWith(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFB76D68),
  scaffoldBackgroundColor: const Color(0xFFF9F9F9),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFB76D68),
    centerTitle: true,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFB76D68),
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
  ),
  iconTheme: const IconThemeData(color: Colors.black87, size: 24),
  cardTheme: CardThemeData(
    color: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    elevation: 4,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    suffixStyle: TextStyle(
      color: Color(0xFFB76D68),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    counterStyle: TextStyle(color: Colors.black54),
    labelStyle: TextStyle(color: Colors.black87),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.black38, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFFB76D68), width: 2),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 100,
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(color: Colors.black87, fontSize: 14),
    ),
    labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    backgroundColor: const Color(0xFFF9F9F9),
    indicatorColor: const Color(0xFFEADFDA),
    iconTheme: WidgetStateProperty.all(
      const IconThemeData(color: Color(0xFFB76D68), size: 24),
    ),
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20),
    contentTextStyle: TextStyle(color: Colors.black54, fontSize: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFB76D68),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.black38, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Color(0xFFB76D68), width: 2),
      ),
      labelStyle: TextStyle(color: Colors.black87),
    ),
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    headerBackgroundColor: const Color(0xFFB76D68),
    headerForegroundColor: Colors.white,
    headerHeadlineStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headerHelpStyle: const TextStyle(color: Colors.white70, fontSize: 14),

    dayStyle: const TextStyle(color: Colors.black87, fontSize: 16),
    dayForegroundColor: const WidgetStatePropertyAll(Colors.black87),
    dayBackgroundColor: WidgetStateProperty.all(Colors.transparent),

    todayForegroundColor: const WidgetStatePropertyAll(Color(0xFFB76D68)),

    weekdayStyle: const TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.bold,
    ),
    yearStyle: const TextStyle(color: Colors.black54),
    yearForegroundColor: const WidgetStatePropertyAll(Colors.black87),
    yearBackgroundColor: const WidgetStatePropertyAll(Colors.transparent),

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 6,
  ),
);