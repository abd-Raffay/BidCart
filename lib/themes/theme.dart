import 'package:bidcart/themes/text_theme.dart';
import 'package:flutter/material.dart';

class BidcartTheme {

  static ThemeData lightTheme = ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.cyan,
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Colors.white,
        onPrimaryContainer: Color(0xFF002020),
        secondary: Color(0xFF4A6363),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFFCCE8E7),
        onSecondaryContainer: Color(0xFF051F1F),
        tertiary: Color(0xFF4B607C),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFD3E4FF),
        onTertiaryContainer: Color(0xFF041C35),
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFFFFDAD6),
        onError: Color(0xFFFFFFFF),
        onErrorContainer: Color(0xFF410002),
        background: Color(0xFFFAFDFC),
        onBackground: Color(0xFF191C1C),
        surface: Color(0xFFFAFDFC),
        onSurface: Color(0xFF191C1C),
        surfaceVariant: Color(0xFFDAE5E4),
        onSurfaceVariant: Color(0xFF3F4948),
        outline: Color(0xFF6F7979),
        onInverseSurface: Color(0xFFEFF1F0),
        inverseSurface: Color(0xFF2D3131),
        inversePrimary: Colors.cyan,
        shadow: Color(0xFF000000),
        surfaceTint: Colors.white,
        outlineVariant: Color(0xFFBEC9C8),
        scrim: Color(0xFF000000),
      ),

      useMaterial3: true,
      fontFamily: "Roboto",
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
          color: Colors.white),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15))))
  //brightness: Brightness.light,

  //brightness: Brightness.light,

      );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF006A6A),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF00FBFB),
      onPrimaryContainer: Color(0xFF002020),
      secondary: Color(0xFF4A6363),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFCCE8E7),
      onSecondaryContainer: Color(0xFF051F1F),
      tertiary: Color(0xFF4B607C),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFD3E4FF),
      onTertiaryContainer: Color(0xFF041C35),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFAFDFC),
      onBackground: Color(0xFF191C1C),
      surface: Color(0xFFFAFDFC),
      onSurface: Color(0xFF191C1C),
      surfaceVariant: Color(0xFFDAE5E4),
      onSurfaceVariant: Color(0xFF3F4948),
      outline: Color(0xFF6F7979),
      onInverseSurface: Color(0xFFEFF1F0),
      inverseSurface: Color(0xFF2D3131),
      inversePrimary: Color(0xFF00DDDD),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF006A6A),
      outlineVariant: Color(0xFFBEC9C8),
      scrim: Color(0xFF000000),
    )
      ,
      useMaterial3: true,
      fontFamily: "Roboto",

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
