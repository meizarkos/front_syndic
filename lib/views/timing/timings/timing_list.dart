import 'package:flutter/material.dart';

import '../../../models/timing/timing.dart';
import '../../../text/fr.dart';

class TimingList extends StatefulWidget {
  const TimingList({
    super.key,
    required this.futureGetAllTimings,
  });

  final Future<List<Timing>?> futureGetAllTimings;

  @override
  State<TimingList> createState() => _TimingListState();
}

class _TimingListState extends State<TimingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.timingListTitle),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
