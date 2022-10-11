import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.pink,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color:Colors.black,
    ),
    elevation: 0.0,
    backgroundColor: Colors.white,
    backwardsCompatibility: false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark ,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      fontWeight: FontWeight.bold ,
    ),

  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type :BottomNavigationBarType.fixed ,
    selectedItemColor: Colors.pink,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
  ),
  fontFamily: 'Sausage',

  // switchTheme: Colors.deepOrange,
);