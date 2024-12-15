import 'package:flutter/material.dart';

import '../../text/fr.dart';

class InProgressMain extends StatefulWidget {
  const InProgressMain({
    super.key,
    required this.top,
    required this.body,
    required this.bottomBar,
  });

  final Widget top;
  final Widget body;
  final BottomNavigationBar bottomBar;

  @override
  State<InProgressMain> createState() => _InProgressMainState();
}

class _InProgressMainState extends State<InProgressMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppText.inProgress),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          widget.top,
          Expanded(
            child: widget.body,
          ),
        ],
      ),
      bottomNavigationBar: widget.bottomBar,
    );
  }
}
