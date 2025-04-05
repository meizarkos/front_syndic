import 'package:flutter/material.dart';

import '../../../core_value.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/text_style/text_style_main_color.dart';

class StatusOfRequest {
  static const String waitingForTiming = 'En attente de rendez-vous';
  static const String timingCreated = 'Rendez-vous pour le ';
  static const String waitingForEstimate = 'En attente de devis';
  static const String debateEstimate = 'Devis en cours de négociation';
  static const String estimateAccepted = 'Devis accepté, aucune date de travaux fixée';
  static const String timingEstimateToDebate = 'Date de travaux proposée pour le ';
  static const String toPay = 'Devis à payer';
  static const String ready = 'Travaux pour le ';
  static const String inProgress = 'Travaux en cours';
  static const String finished = 'Travaux terminés';

  static const Map<String, Color> statusColors = {
    waitingForTiming: Colors.grey,
    timingCreated: Colors.blue,
    waitingForEstimate: Colors.orange,
    debateEstimate: Colors.purple,
    estimateAccepted: Colors.green,
    timingEstimateToDebate: Colors.cyan,
    toPay: Colors.red,
    ready: Colors.blueAccent,
    inProgress: Colors.amber,
    finished: Colors.teal,
  };

  static Color getStatusColor(String status) {
    for (final entry in statusColors.entries) {
      if (status.startsWith(entry.key)) {
        return entry.value;
      }
    }
    return Colors.black; // default if no match
  }
}

class CellConversation extends StatelessWidget {
  const CellConversation({
    super.key,
    required this.status,
    required this.workRequestTitle,
    required this.lastMessage,
    this.dateOfLastMessage,
  });

  final String status;
  final String workRequestTitle;
  final String lastMessage;
  final String? dateOfLastMessage;

  @override
  Widget build(BuildContext context) {
    const space = AppUIValue.spaceScreenToAny;
    return Card(
      elevation: AppUIValue.elevation,
      child: Container(
        decoration: decorationRoundMainColor(),
        padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
        child: Column(
          children: [
            Text(
                trimText(workRequestTitle, 25),
                style: getTextStyleMainColor(16)
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                trimText(lastMessage,45),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(height: space),
            Text(
              status,
              style: TextStyle(
                color: StatusOfRequest.getStatusColor(status),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
