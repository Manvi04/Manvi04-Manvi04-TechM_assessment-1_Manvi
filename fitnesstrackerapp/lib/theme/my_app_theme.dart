import 'package:flutter/material.dart';

final ThemeData myAppTheme = ThemeData().copyWith(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFFB76D68),
  scaffoldBackgroundColor: const Color(0xFF121420),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFB76D68),
    centerTitle: true,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFB76D68),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
  ),
  iconTheme: const IconThemeData(color: Colors.white, size: 24),
  cardTheme: CardThemeData(
    color: Color(0xFF2C2B3C),
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    suffixStyle: TextStyle(
      color: Color(0xFFB76D68),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    counterStyle: TextStyle(color: Colors.white70),
    labelStyle: TextStyle(color: Colors.white),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.white, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFFB76D68), width: 2),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    height: 100,
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(color: Colors.white, fontSize: 14),
    ),
    labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    backgroundColor: const Color(0xFF121420),
    // backgroundColor: const Color(0xFF1B2432),
    indicatorColor: const Color(0xFF403F4C),
    // indicatorColor: const Color(0xFFB76D68),
    iconTheme: WidgetStateProperty.all(
      IconThemeData(color: Color(0xFFB76D68), size: 24),
    ),
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: Color(0xFF2C2B3C),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    contentTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFB76D68),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.white, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Color(0xFFB76D68), width: 2),
      ),
      labelStyle: TextStyle(color: Colors.white),
      // iconColor: Color(0xFFB76D68),
    ),
  ),

  datePickerTheme: DatePickerThemeData(
    backgroundColor: Color(0xFF2C2B3C), // Main background
    surfaceTintColor: Colors.transparent, // Prevents unexpected color overlays
    // HEADER
    headerBackgroundColor: Color(0xFFB76D68),
    headerForegroundColor: Colors.white,
    headerHeadlineStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    headerHelpStyle: TextStyle(color: Colors.white70, fontSize: 14),

    // DAY STYLE
    dayStyle: TextStyle(color: Colors.white, fontSize: 16),
    dayForegroundColor: WidgetStatePropertyAll(Colors.white),
    dayBackgroundColor: WidgetStateProperty.all(Colors.transparent),

    // TODAY
    todayForegroundColor: WidgetStatePropertyAll(Colors.white),

    // WEEKDAY & YEAR
    weekdayStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
    yearStyle: TextStyle(color: Colors.white70),
    yearForegroundColor: WidgetStatePropertyAll(Colors.white),
    yearBackgroundColor: WidgetStatePropertyAll(Colors.transparent),

    // SHAPE & BORDER
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 6,
  ),
);