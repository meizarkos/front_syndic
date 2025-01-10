import 'package:flutter/material.dart';

import '../../core_value.dart';
import '../../text/fr.dart';

ElevatedButton deleteButton(Function onPressed, BuildContext context) {
  return ElevatedButton(
    onPressed: () => {
      onPressed(),
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Background color with opacity
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      textStyle: Theme.of(context).textTheme.displayMedium,
      elevation: AppUIValue.elevation,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppText.delete,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        SizedBox(width: 15),
        Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ],
    ),
  );
}