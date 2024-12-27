import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/header/header_type.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/recap_main.dart';

import '../../../text/fr.dart';
import 'handler_body/handler_body_council.dart';
import 'handler_body/handler_body_union.dart';

class RecapMainCouncil extends StatefulWidget {
  const RecapMainCouncil({
    super.key,
    required this.workRequestUuid,
  });

  final String? workRequestUuid;

  @override
  State<RecapMainCouncil> createState() => _RecapMainCouncilState();
}

class _RecapMainCouncilState extends State<RecapMainCouncil> {

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
        top: HeaderCouncil(category: category, onCategoryChange: onCategoryChange),
        bottom: handlerBodyCouncil(category, widget.workRequestUuid!),
    );
  }

  void onCategoryChange(String category) {
    setState(() {
      this.category = category;
    });
  }
}

class RecapMainUnion extends StatefulWidget {
  const RecapMainUnion({
    super.key,
    required this.workRequestUuid,
  });

  final String? workRequestUuid;

  @override
  State<RecapMainUnion> createState() => _RecapMainUnionState();
}

class _RecapMainUnionState extends State<RecapMainUnion> {

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
      top: HeaderUnion(category: category, onCategoryChange: onCategoryChange),
      bottom: handlerBodyUnion(category, widget.workRequestUuid!),
    );
  }

  void onCategoryChange(String category) {
    setState(() {
      this.category = category;
    });
  }
}

