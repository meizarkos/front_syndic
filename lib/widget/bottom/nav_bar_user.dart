import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_syndic/color.dart';

import '../../text/fr.dart';

void goToAndDeleteAll(BuildContext context, String route, int index, int selectedIndex) {
  if(index == selectedIndex) return;
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
        (Route<dynamic> route) => false, // Removes all previous routes
  );
}

BottomNavigationBar bottomNavigationBarUser(BuildContext context, int selectedIndex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon:Icon(Icons.home),
        label: AppText.home,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/message.svg',
          width: 24.0,
          height: 24.0,
        ),
        label: AppText.conversationNavTitle,
      ),
    ],
    currentIndex: selectedIndex,
    onTap: (int index)=>{
      if(index == 0){
        goToAndDeleteAll(context, '/user_main',0, selectedIndex)
      }
      else if(index == 1){
        goToAndDeleteAll(context, '/user/conversation', 1, selectedIndex)
      }
    },
    selectedItemColor: AppColors.mainTextColor,
    unselectedItemColor: Colors.grey,
  );
}
