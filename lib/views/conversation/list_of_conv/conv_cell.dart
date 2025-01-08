import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/text/fr.dart';

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
          padding: const EdgeInsets.only(left : AppUIValue.spaceScreenToAny, right: AppUIValue.spaceScreenToAny, bottom: 10),
          child: Column(
            crossAxisAlignment: fromYou ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left : AppUIValue.spaceScreenToAny, right : AppUIValue.spaceScreenToAny,
                    top : AppUIValue.spaceScreenToAny/2, bottom : AppUIValue.spaceScreenToAny/2
                ),
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
                    message ?? AppText.workRequestNoMessage,
                    style: Theme.of(context).textTheme.displaySmall,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                fromDateTimeToConvString(createdAt),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 9,
                ),
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
