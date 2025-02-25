import 'package:flutter/material.dart';
import '../../text/fr.dart';

SingleChildRenderObjectWidget addFloatingButton(VoidCallback? goTo){
  if(goTo == null){
    return SizedBox();
  }
  return Align(
    alignment: Alignment.bottomCenter,
    child: FloatingActionButton.extended(
      onPressed: goTo,
      backgroundColor: Colors.black,
      label: const Row(
        children: [
          Text(
            AppText.unionMainAddButton,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8), // Add space between text and icon
          Icon(
            Icons.add_box,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}