import 'package:flutter/cupertino.dart';

Size appBarSize(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return Size(MediaQuery.of(context).size.width,screenHeight * 0.12);
}