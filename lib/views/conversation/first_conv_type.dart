import 'package:flutter/material.dart';

import '../../api_handler/conversation/fetch_conversation.dart';
import 'first_conv.dart';

class FirstConvCouncil extends StatelessWidget {
  const FirstConvCouncil({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return FirstConv(
      future: fetchFirstConvCouncil(id),
    );
  }
}
