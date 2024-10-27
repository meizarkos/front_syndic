import 'package:flutter/material.dart';

AppBar appBarBackButton(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context); // Return to previous screen
      },
    ),
  );
}