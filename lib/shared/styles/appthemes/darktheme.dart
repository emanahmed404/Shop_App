import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme =ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: Colors.pink,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    elevation: 0.0,
    backgroundColor: HexColor('333739'),
    backwardsCompatibility: false ,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739') ,
      statusBarIconBrightness: Brightness.light ,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.bold ,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),

  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type :BottomNavigationBarType.fixed ,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  fontFamily: 'Sausage',


  // switchTheme: Colors.deepOrange,
);