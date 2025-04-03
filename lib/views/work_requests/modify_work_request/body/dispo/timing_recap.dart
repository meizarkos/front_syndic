import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../../../../models/timing/timing.dart';
import '../../../../../../text/fr.dart';
import '../../../../../../widget/visibility/error.dart';
import '../../../create_work_request/chose_time/cell_time.dart';

class RecapTimingChange extends StatefulWidget {
  const RecapTimingChange({
    super.key,
    required this.uuid,
    required this.fetchAllTimingFromWorkRequest,
    required this.patchAllTimingFromWorkRequest,
  });

  final Future<List<Timing>?> Function(String) fetchAllTimingFromWorkRequest;
  final Future<void> Function(String, List<Timing>?) patchAllTimingFromWorkRequest;
  final String uuid;

  @override
  State<RecapTimingChange> createState() => _RecapTimingChange();
}

class _RecapTimingChange extends State<RecapTimingChange> {
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  List<Timing>? timings = [];

  bool apiErrorVisibility = false;
  bool errorVisibility = false;
  bool successVisibility = false;

  @override
  void initState() {
    super.initState();
    widget.fetchAllTimingFromWorkRequest(widget.uuid).then((value) {
      if (value == null) {
        setState(() {
          apiErrorVisibility = true;
        });
      } else {
        setState(() {
          timings = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: firstDate,
              lastDate: lastDate,
              onDateChanged: onDateChanged,
            ),
            ErrorVisibility(
              errorVisibility: errorVisibility,
              errorText: AppText.createWorkRequestTimingWrong,
            ),
            const SizedBox(height: 20),
            if (timings != null &&
                timings!.isNotEmpty)
              ...timings!.map((date) {
                if (date.date == null || date.time == null) {
                  return const SizedBox();
                }
                return CreateWorkRequestCellTime(
                  date: date.date!,
                  time: date.time!,
                  onDelete: () {
                    setState(() {
                      timings!.remove(date);
                    });
                  },
                );
              }),
            const SizedBox(height: 35),
            Center(
              child: Visibility(
                  visible: successVisibility,
                  child: const Text(
                    AppText.recapSuccessModifying,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  )),
            ),
            elevatedButtonAndTextColor(
              AppColors.mainBackgroundColor,
              AppText.save,
              context,
              _onSave,
              AppColors.mainTextColor,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
    void onDateChanged(DateTime date) {
      setState(() {
        selectedDate = date;
      });
      _choseTime();
    }

    Future<void> _choseTime() async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 10, minute: 00),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );
      if (pickedTime == null) {
        return;
      }
      setState(() {
        errorVisibility = false;
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        timings ??= [];
        if (timings!.length > 10) {
          timings!.removeLast();
        }
        timings!.add(
          Timing(
            date:
                '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
            time: '${selectedDate.hour}:${selectedDate.minute}',
          ),
        );
      });
    }

  void _onSave() {
    if (timings == null || timings!.isEmpty) {
      setState(() {
        successVisibility = false;
        errorVisibility = true;
      });
      return;
    }
    widget.patchAllTimingFromWorkRequest(widget.uuid, timings);
    setState(() {
      successVisibility = true;
      errorVisibility = false;
    });
  }
}
