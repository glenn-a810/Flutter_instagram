import 'package:flutter/material.dart';

var theme = ThemeData(
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.white,
    elevation: 1,
  ),
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     backgroundColor: Colors.red,
  //   ),
  // ),
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