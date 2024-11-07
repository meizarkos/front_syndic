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
    required this.title,
    required this.subtitle,
    required this.adress,
  });

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
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                trimText(stringNullOrDefaultValue(title, AppText.noTitleForWork), 22),
                style: getTextStyleMainColor(22.0),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              Text(
                "${adress?.city} ${adress?.region}\n${adress?.street} ",
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              const SizedBox(height: 50),
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
