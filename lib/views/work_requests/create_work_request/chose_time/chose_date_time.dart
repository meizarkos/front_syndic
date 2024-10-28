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

  List<DateTime> selectedDates = [];
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
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
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 20),
            ...selectedDates.map((date) {
              return CreateWorkRequestCellTime(
                date: date,
                onDelete: () {
                  setState(() {
                    selectedDates.remove(
                        date); // Removed `!` assuming selectedDates is not nullable
                  });
                },
              );
            }),
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
      if (selectedDates.length > 10) {
        selectedDates.removeLast();
      }
      selectedDates.add(selectedDate);
    });
  }

  void _onSave() {
    if (selectedDates.isEmpty) {
      setState(() {
        errorVisibility = true;
      });
      return;
    }
    widget.createWorkRequest.workRequest.timings = [];
    for (int i = 0; i < selectedDates.length; i++) {
      widget.createWorkRequest.workRequest.timings?.add(Timing(
        time: selectedDates[i].toString(),
      ));
    }
    setState(() {
      selectedDates = [];
    });
    Navigator.pop(context);
  }
}
