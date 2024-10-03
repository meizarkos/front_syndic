import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';


class HeaderForAll extends StatelessWidget{
  const HeaderForAll({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = screenHeight * 0.2;

    return AppBar(
      title: const Text(
          'Fixiia',
      ),
      backgroundColor: AppColors.mainBackgroundColor,
      elevation: 0,
      toolbarHeight: appBarHeight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.0),
        ),
      ),
    );
  }
}
