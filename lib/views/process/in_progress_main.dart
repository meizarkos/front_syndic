import 'package:flutter/material.dart';

class InProgressMain extends StatefulWidget {
  const InProgressMain({super.key});

  @override
  State<InProgressMain> createState() => _InProgressMainState();
}

class _InProgressMainState extends State<InProgressMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
