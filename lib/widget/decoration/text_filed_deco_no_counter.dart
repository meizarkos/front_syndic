import 'package:flutter/material.dart';

InputDecoration roundBorderTextFieldWithoutCounter(String text) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), // Set corner radius here
    ),
    labelText: text,
    counterText: '',
  );
}