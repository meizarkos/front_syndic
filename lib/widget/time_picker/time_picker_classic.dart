import 'package:flutter/material.dart';
import '../../text/fr.dart';
import '../decoration/text_filed_deco_no_counter.dart';

class TimePickerClassic extends StatelessWidget {
  const TimePickerClassic({
    super.key,
    required this.onChangedMinute,
    required this.onChangedHour,
  });

  final ValueChanged onChangedHour;
  final ValueChanged onChangedMinute;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          margin: const EdgeInsets.all(15),
          child: TextField(
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            onChanged: onChangedHour,
            decoration: roundBorderTextFieldWithoutCounter(
              AppText.hour,
            ),
            maxLines: 6,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            maxLength: 2,
            minLines: 1,
          ),
        ),
        Text(
          ':',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          margin: const EdgeInsets.all(15),
          child: TextField(
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            onChanged: onChangedMinute,
            decoration: roundBorderTextFieldWithoutCounter(
              AppText.minute,
            ),
            maxLines: 6,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            maxLength: 2,
            minLines: 1,
          ),
        ),
      ],
    );
  }
}
