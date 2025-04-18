import 'package:flutter/material.dart';
import 'package:front_syndic/models/adress/adress.dart';

import '../../core_value.dart';
import '../../text/fr.dart';
import '../../utils/string_handler/handle_string.dart';
import '../../widget/decoration/decoration_round_main_color.dart';
import '../../widget/text_style/text_style_main_color.dart';

class CellWorkRequestArtisanSide extends StatelessWidget {
  const CellWorkRequestArtisanSide({
    super.key,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.adress,
  });

  final String? category;
  final String? title;
  final String? subtitle;
  final Adress? adress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
      child: Card(
        elevation: AppUIValue.elevation,
        child: Container(
          decoration: decorationRoundMainColor(),
          padding: const EdgeInsets.only(
            left: AppUIValue.spaceScreenToAny,
            right: AppUIValue.spaceScreenToAny,
            top: 5,
            bottom: AppUIValue.spaceScreenToAny,
          ),
          child: Column(
            children: [
              Text(
                trimText(title ?? AppText.noTitleForWork, 22),
                style: getTextStyleMainColor(18.0),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${AppText.interventionPlace} \n",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    TextSpan(
                      text: "${adress?.city ?? ''}, ${adress?.region ?? ''}\n${adress?.street ??''}",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                category ?? AppText.noCategoryFound,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                trimText(stringNullOrDefaultValue(subtitle, AppText.noDescriptionWorkRequest), 100),
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
