import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';

import '../../../core_value.dart';
import '../../../utils/date_to_string/date.dart';

class ConvCell extends StatelessWidget {
  const ConvCell({
    super.key,
    required this.message,
    required this.createdAt,
    required this.side,
  });

  final String? message;
  final String? createdAt;
  final bool side;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: side ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            crossAxisAlignment: side ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                decoration: BoxDecoration(
                  color: side ?  AppColors.mainBackgroundColor : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  stringNullOrDefaultValue(message,AppText.workRequestNoMessage),
                  style: Theme.of(context).textTheme.displaySmall,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                fromDateTimeToConvString(createdAt),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
