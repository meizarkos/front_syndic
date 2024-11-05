import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/utils/date_to_string/date.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../../models/timing/timing.dart';
import '../../../../models/work_request/create_work_request.dart';
import '../../../../text/fr.dart';
import '../../../../widget/visibility/error.dart';
import 'cell_time.dart';

class ChoseDateTime extends StatefulWidget {
  const ChoseDateTime({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  State<ChoseDateTime> createState() => _ChoseDateTimeState();
}

class _ChoseDateTimeState extends State<ChoseDateTime> {
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  bool errorVisibility = false;

  @override
  void initState() {
    super.initState();
    widget.createWorkRequest.workRequest.timings ??= [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title : AppText.createWorkRequestInterventionDate),
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
            GestureDetector(
              onTap: _choseTime,
              child: Text(
                '${AppText.createWorkRequestTiming} ${fromCalendarToString(selectedDate.day, selectedDate.month, selectedDate.year)}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 20),
            if (widget.createWorkRequest.workRequest.timings != null &&
                widget.createWorkRequest.workRequest.timings!.isNotEmpty)
              ...widget.createWorkRequest.workRequest.timings!.map((date) {
                if(date.date == null || date.time == null){
                  return const SizedBox();
                }
                return CreateWorkRequestCellTime(
                  date: date.date!,
                  time: date.time!,
                  onDelete: () {
                    setState(() {
                      widget.createWorkRequest.workRequest.timings!.remove(date);
                    });
                  },
                );
              }),
            const SizedBox(height: 35),
            elevatedButtonOpacityAndTextColor(
              AppColors.mainBackgroundColor,
              AppText.save,
              context,
              _onSave,
              AppColors.mainTextColor,
            )
          ],
        ),
      ),
    );
  }

  void onDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  Future<void> _choseTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 47),
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
      widget.createWorkRequest.workRequest.timings ??= [];
      if (widget.createWorkRequest.workRequest.timings!.length > 10) {
        widget.createWorkRequest.workRequest.timings!.removeLast();
      }
      widget.createWorkRequest.workRequest.timings!.add(
        Timing(
          date: '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
          time: '${selectedDate.hour}:${selectedDate.minute}',
        ),
      );
    });
  }

  void _onSave() {
    if (widget.createWorkRequest.workRequest.timings == null || widget.createWorkRequest.workRequest.timings!.isEmpty) {
      setState(() {
        errorVisibility = true;
      });
      return;
    }
    Navigator.pushNamed(context, '/work_requests/recap', arguments: widget.createWorkRequest);
  }
}
