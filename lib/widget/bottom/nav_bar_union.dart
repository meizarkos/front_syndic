import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_syndic/color.dart';

import '../../text/fr.dart';

const double iconSize = 18.0;

void goToAndDeleteAll(BuildContext context, String route, int index, int selectedIndex) {
  if(index == selectedIndex) return;
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
        (Route<dynamic> route) => false, // Removes all previous routes
  );
}

BottomNavigationBar bottomNavigationBarUnion(BuildContext context, int selectedIndex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon:Icon(
            Icons.home,
            size: iconSize,
        ),
        label: AppText.home,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/tools.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppText.workRequest,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/message.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppText.conversationNavTitle,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/invoice.svg',
          width: iconSize,
          height: iconSize,
        ),
        label: AppText.invoice,
      ),
    ],
    currentIndex: selectedIndex,
    onTap: (int index)=>{
      if(index == 0){
        goToAndDeleteAll(context, '/union_main',0, selectedIndex)
      }
      else if(index == 1){
        goToAndDeleteAll(context, '/union/work_requests',1, selectedIndex)
      }
      else if(index == 2){
          goToAndDeleteAll(context, '/union/conversation', 2, selectedIndex)
      }
      else if(index == 3){
          goToAndDeleteAll(context, '/union/invoice',3, selectedIndex)
      }
    },
    selectedItemColor: AppColors.mainTextColor,
    unselectedItemColor: Colors.grey,
  );
}


// /in_progress/union