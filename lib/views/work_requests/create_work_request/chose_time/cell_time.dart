import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';

import '../../../../text/fr.dart';

class CreateWorkRequestCellTime extends StatelessWidget {
  const CreateWorkRequestCellTime({
    super.key,
    required this.date,
    required this.onDelete,
  });

  final DateTime date;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
      margin: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${AppText.le} ${date.day}/${date.month}/${date.year} ${AppText.at} ${date.hour}h${date.minute}',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
