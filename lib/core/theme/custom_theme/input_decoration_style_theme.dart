import 'package:flutter/material.dart';

abstract class InputDecorationStyleTheme {

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle:  const TextStyle().copyWith(fontSize: 14,color: Colors.black),
      hintStyle:   const TextStyle().copyWith(fontSize: 14,color: Colors.black),
      errorStyle:  const TextStyle().copyWith(fontStyle: FontStyle.normal,),
      floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
      border:  InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
      errorMaxLines: 3,
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      labelStyle:  const TextStyle().copyWith(fontSize: 14,color: Colors.white),
      hintStyle:   const TextStyle().copyWith(fontSize: 14,color: Colors.white),
      errorStyle:  const TextStyle().copyWith(fontStyle: FontStyle.normal),
      floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none
  );
}