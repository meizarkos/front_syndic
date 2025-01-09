import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/handler_body/handler_body_council.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/recap_main.dart';

import '../../../text/fr.dart';
import 'handler_body/handler_body_union.dart';
import 'header/header_type.dart';

class RecapMainUnionFromConversation extends StatefulWidget {
  const RecapMainUnionFromConversation({
    super.key,
    required this.workRequestUuid,
  });

  final String? workRequestUuid;

  @override
  State<RecapMainUnionFromConversation> createState() => _RecapMainUnionFromConversationState();
}

class _RecapMainUnionFromConversationState extends State<RecapMainUnionFromConversation> {

  String category = AppText.demand;

  @override
  Widget build(BuildContext context) {
    if (widget.workRequestUuid == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return const SizedBox(); // Return an empty widget while the pop is handled
    }
    return RecapMain(
      top: HeaderUnionFromConversation(category: category, onCategoryChange: onCategoryChange),
      bottom: handlerBodyUnion(category, widget.workRequestUuid!),
    );
  }

  void onCategoryChange(String category) {
    setState(() {
      this.category = category;
    });
  }
}

class RecapMainCouncilFromConversation extends StatefulWidget {
  const RecapMainCouncilFromConversation({
    super.key,
    required this.workRequestUuid,
  });

  final String? workRequestUuid;

  @override
  State<RecapMainCouncilFromConversation> createState() => _RecapMainCouncilFromConversationState();
}

class _RecapMainCouncilFromConversationState extends State<RecapMainCouncilFromConversation> {

  String category = AppText.demand;

  @override
  Widget build(BuildContext context) {
    if (widget.workRequestUuid == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return const SizedBox(); // Return an empty widget while the pop is handled
    }
    return RecapMain(
      top: HeaderCouncilFromConversation(category: category, onCategoryChange: onCategoryChange),
      bottom: handlerBodyCouncil(category, widget.workRequestUuid!),
    );
  }

  void onCategoryChange(String category) {
    setState(() {
      this.category = category;
    });
  }
}