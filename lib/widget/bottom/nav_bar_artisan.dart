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

BottomNavigationBar bottomNavigationBarArtisan(BuildContext context, int selectedIndex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon:Icon(Icons.home),
        label: AppText.home,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/tools.svg',
          width: 24.0,
          height: 24.0,
        ),
        label: AppText.workRequest,
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          'assets/invoice.svg',
        ),
        label: AppText.invoice,
      ),
    ],
    currentIndex: selectedIndex,
    onTap: (int index)=>{
      if(index == 0){
        goToAndDeleteAll(context, '/in_progress/artisan', 0, selectedIndex)
      }
      else if(index == 1){
        goToAndDeleteAll(context, '/artisan_main',1, selectedIndex)
      }
      else if(index == 2){
        goToAndDeleteAll(context, '/artisan/invoice',2, selectedIndex)
      }
    },
    selectedItemColor: AppColors.mainTextColor,
    unselectedItemColor: Colors.grey,
  );
}
