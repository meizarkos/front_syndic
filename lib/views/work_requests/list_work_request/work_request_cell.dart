import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';

import '../../../../text/fr.dart';
import '../../../../widget/decoration/decoration_round_main_color.dart';
import '../../../../widget/text_style/text_style_main_color.dart';

class WorkRequestCell extends StatelessWidget {
  const WorkRequestCell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  final String? title;
  final String? subtitle;
  final String? type;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
      child: Card(
        elevation: AppUIValue.elevation,
        child: Container(
          decoration: decorationRoundMainColor(),
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                trimText(title ?? AppText.noTitleForWork, 22),
                style: getTextStyleMainColor(22.0),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              RichText(
                textAlign: TextAlign.center,
                maxLines: 1,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${AppText.category}: ',
                      style: Theme.of(context).textTheme.displayMedium, // First font
                    ),
                    TextSpan(
                      text: type ?? AppText.noCategoryFound,
                      style: Theme.of(context).textTheme.displayMedium, // Second font
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                trimText(subtitle ?? AppText.noDescriptionWorkRequest, 200),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
