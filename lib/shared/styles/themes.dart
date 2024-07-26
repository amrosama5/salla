import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    color: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  primarySwatch: Colors.blue,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: Colors.blueGrey,
    elevation: 20.0,
    selectedIconTheme: IconThemeData(
      size: 30.0,
    ),
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 10.0,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: const Color(0xff333739),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xff333739),
      statusBarIconBrightness: Brightness.light,
    ),
    color: Color(0xff333739),
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xff333739),
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 10.0,
    ),
  ),
);