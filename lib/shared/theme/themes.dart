import 'package:flutter/material.dart';

class DefaultThemes {
  final ThemeData darkTheme = ThemeData(
      fontFamily: 'Timmana',
      brightness: Brightness.dark,
      primaryColor: Colors.amber,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.amber,
        disabledColor: Colors.grey,
      ));

  ThemeData lightTheme = ThemeData(
      fontFamily: 'Timmana',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blue,
        disabledColor: Colors.grey,
      ));
}
