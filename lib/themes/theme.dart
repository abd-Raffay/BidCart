import 'package:bidcart/themes/text_theme.dart';
import 'package:flutter/material.dart';

class BidcartTheme {

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Preahvihear",
      brightness: Brightness.light,
      primaryColor: Colors.cyan,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: Colors.cyan,
              disabledBackgroundColor: Colors.grey,
              disabledForegroundColor: Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 20),
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: "Preahvihear",
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)))),

      outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(

      foregroundColor: Colors.white,
      //backgroundColor: Colors.cyan,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      //padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16,
          fontFamily: "Preahvihear",
          color: Colors.white),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15))))
  //brightness: Brightness.light,

  //brightness: Brightness.light,

      );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Preahvihear",
      brightness: Brightness.dark,
      primaryColor: Colors.cyan,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TTextTheme.lightTextTheme,

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.cyan,
              disabledBackgroundColor: Colors.grey,
              disabledForegroundColor: Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 18),
              textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))))
    //brightness: Brightness.light,

  );
}

BidcartTheme _bidcartTheme = BidcartTheme();
