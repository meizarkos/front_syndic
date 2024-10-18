import 'package:flutter/material.dart';
import '../../core_value.dart';

ElevatedButton elevatedButtonOpacity(Color backgroundColor, String buttonText, BuildContext context,VoidCallback goTo) {
  return ElevatedButton(
    onPressed: goTo,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor, // Background color with opacity
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      textStyle: Theme.of(context).textTheme.displayMedium,
      elevation: AppUIValue.elevation,
      shadowColor: Colors.black.withOpacity(AppUIValue.opacityActionButtonShadow),
    ),
    child: Text(
      buttonText,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
  );
}