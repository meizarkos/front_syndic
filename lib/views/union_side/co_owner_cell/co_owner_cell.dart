import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';
import 'package:front_syndic/widget/text_style/text_style_main_color.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';

class CoOwnerCell extends StatelessWidget {
  const CoOwnerCell({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppUIValue.elevation,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: decorationRoundMainColor(),
          child: Column(
          children: [
            Text(
              trimText(stringNullOrDefaultValue(title, AppText.noStringNameForCowner),11),
              style: getTextStyleMainColor(20.0),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Text(
              trimText(stringNullOrDefaultValue(subtitle, AppText.noStringNameForCownerSubtitle),50),
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
