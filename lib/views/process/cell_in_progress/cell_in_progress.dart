import 'package:flutter/material.dart';

import '../../../core_value.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/text_style/text_style_main_color.dart';

class CellInProgress extends StatelessWidget {
  const CellInProgress({
    super.key,
    required this.workRequestTitle,
    required this.desc,
    required this.descSize,
    required this.descStyle,
    this.thirdText,
    this.thirdTextSize,
  });

  final String workRequestTitle;
  final String desc;
  final TextStyle? descStyle;
  final String? thirdText;
  final int descSize;
  final int? thirdTextSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: AppUIValue.elevation,
        child: Container(
          decoration: decorationRoundMainColor(),
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Text(
                  trimText(workRequestTitle, 25),
                  style: getTextStyleMainColor(18)
              ),
              const SizedBox(height: 15),
              Text(
                  trimText(desc,descSize),
                  style: descStyle,
              ),
              const SizedBox(height: 25),
              if(thirdText != null && thirdTextSize != null)
                Text(
                    trimText(thirdText!, thirdTextSize!),
                    style: Theme.of(context).textTheme.displaySmall
                ),
            ],
          ),
        ),
      ),
    );
  }
}
