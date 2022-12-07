import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(String hintText) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
      hintText: hintText,
    );
  }
}
