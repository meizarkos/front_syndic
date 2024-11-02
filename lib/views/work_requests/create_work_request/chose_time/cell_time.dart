import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:intl/intl.dart';

import '../../../../text/fr.dart';

class CreateWorkRequestCellTime extends StatelessWidget {
  const CreateWorkRequestCellTime({
    super.key,
    required this.date,
    required this.time,
    required this.onDelete,
    this.showIcon = true,
  });

  final String date;
  final String time;
  final VoidCallback onDelete;
  final bool showIcon;

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
            '${AppText.le} ${formatDateString(date)} ${AppText.at} $time',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          GestureDetector(
            onTap: onDelete,
            child: Visibility(
              visible: showIcon,
              child: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  String formatDateString(String dateString) {
    DateTime? parsedDate;
    List<String> formats = ["yyyy-M-d", "yyyy-MM-dd","yyyy-MM-d", "yyyy-M-dd"];
    for (String format in formats) {
      try {
        parsedDate = DateFormat(format).parseStrict(dateString);
        break; // Stop if parsing is successful
      } catch (e) {
        continue; // Continue to the next format if parsing fails
      }
    }
    
    if (parsedDate == null) {
      return "Invalid date format";
    }
    
    return DateFormat("dd/MM/yyyy").format(parsedDate);
  }
}
