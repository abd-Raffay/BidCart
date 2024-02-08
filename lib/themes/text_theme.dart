import 'package:flutter/material.dart';

class TextFormFeildTheme{
  TextFormFeildTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(),
        prefixIconColor: Colors.black,
        floatingLabelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2,color: Colors.black),
        ));
}