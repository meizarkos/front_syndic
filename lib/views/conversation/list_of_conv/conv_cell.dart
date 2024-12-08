import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';

import '../../../core_value.dart';
import '../../../utils/date_to_string/date.dart';
import 'all_conv_type.dart';

class ConvCell extends StatelessWidget {
  const ConvCell({
    super.key,
    required this.message,
    required this.createdAt,
    required this.fromYou,
    required this.side,
    required this.sideText,
  });

  final String? message;
  final String? createdAt;
  final bool fromYou;
  final String side;
  final String sideText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: fromYou ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            crossAxisAlignment: fromYou ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                decoration: BoxDecoration(
                  color: _handleColorSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 0,
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                  ),
                  child: Text(
                    stringNullOrDefaultValue(message,AppText.workRequestNoMessage),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
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
  Color _handleColorSide(){
    if(fromYou){
      return AppColors.mainBackgroundColor;
    }
    else if(sideText == SideConv.artisan){
      return Colors.grey[300]!;
    }
    else if(sideText == SideConv.other){
      if(side == SideConv.union){
        return Colors.orangeAccent;
      }
      return Colors.grey[300]!;
    }
    else if(sideText == SideConv.union){
      if(side == SideConv.other){
        return Colors.orangeAccent;
      }
      return Colors.grey[300]!;
    }
    else{
      return Colors.grey[300]!;
    }
  }
}
