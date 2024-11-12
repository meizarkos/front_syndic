import 'package:flutter/material.dart';

import '../../models/conversation/conversation.dart';

class FirstConv extends StatelessWidget {
  const FirstConv({
    super.key,
    required this.future,
    this.id,
  });

  final Future<List<Conversation>?> future;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No conversation yet'),
      ),
    );
  }
}
