import 'package:flutter/material.dart';

var theme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.white,
    elevation: 1,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 22,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      color: Colors.blue,
    ),
  ),
);
