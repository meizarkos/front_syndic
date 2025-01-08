import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';

import '../../../../text/fr.dart';

class HeaderForModifyWorkRequest extends StatelessWidget {
  const HeaderForModifyWorkRequest({
    super.key,
    required this.category,
    required this.onChangedCategory,
    required this.onBack,
  });

  final String category;
  final Function(String) onChangedCategory;
  final Function() onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left : AppUIValue.spaceScreenToAny),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _createGestureDetector(AppText.demand),
              const SizedBox(width: AppUIValue.spaceScreenToAny * 2),
              _createGestureDetector(AppText.dispo),
              const SizedBox(width: AppUIValue.spaceScreenToAny * 2),
              _createGestureDetector(AppText.adress),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _createGestureDetector(String value) {
    return GestureDetector(
      onTap: () {
        onChangedCategory(value);
      },
      child: Text(
        value,
        style: TextStyle(
            fontSize: 16,
            fontWeight: category == value ? FontWeight.bold : FontWeight.normal
        ),
      ),
    );
  }
}
