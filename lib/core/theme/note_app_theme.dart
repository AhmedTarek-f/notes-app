import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/constants/colors.dart';
import 'package:notes_app/core/theme/custom_theme/input_decoration_style_theme.dart';

abstract class NoteAppTheme {

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Poppins",
      brightness: Brightness.light,
      primaryColor: NoteColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme().copyWith(backgroundColor: Colors.white),
      inputDecorationTheme:InputDecorationStyleTheme.lightInputDecorationTheme

  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "Poppins",
      brightness: Brightness.dark,
      primaryColor: NoteColors.primaryColor,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme().copyWith(backgroundColor: Colors.black),
      inputDecorationTheme:InputDecorationStyleTheme.darkInputDecorationTheme

  );

}

