import 'package:flutter/material.dart';

import '../../color.dart';
import '../../core_value.dart';
import '../../text/fr.dart';

Container rowBottomBar(BuildContext context, Function modify, Function choiceDelete) {
  return Container(
    margin: const EdgeInsets.only(bottom: AppUIValue.spaceScreenToAny),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: FloatingActionButton.extended(
              backgroundColor: AppColors.rowBackgroundColor,
              onPressed: () => {
                modify(),
              },
              label: Text(
                AppText.modify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            )),
        const SizedBox(width: 10),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.black,
              onPressed: () => {
                choiceDelete(),
              },
              label: const Row(
                children: [
                  Text(
                    AppText.delete,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 25),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
        ),
      ],
    ),
  );
}