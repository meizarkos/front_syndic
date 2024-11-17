import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';

import '../../../models/conversation/conversation.dart';
import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/text_style/text_style_main_color.dart';

class FirstConvCell extends StatelessWidget {
  const FirstConvCell({
    super.key,
    required this.conversation,
  });

  final Conversation conversation;

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
                  trimText(stringNullOrDefaultValue(conversation.workRequest?.title, AppText.noTitleForWork), 25),
                  style: getTextStyleMainColor(20)
              ),
              const SizedBox(height: 15),
              Text(trimText(stringNullOrDefaultValue(conversation.message,AppText.messageNoMessage),150)),
              const SizedBox(height: 25),
              Text(_date()),
            ],
          ),
        ),
      ),
    );
  }

  String _date(){
    if(conversation.createdAt == null){
      return AppText.noDate;
    }
    final date = conversation.createdAt!.split('T');
    return '${AppText.le} ${formatStringToApiDate(date[0],'dd/MM')} ${AppText.at} ${date[1].substring(0,5)}';
  }
}
