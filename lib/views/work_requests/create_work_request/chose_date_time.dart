/*import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/utils/date_to_string/date.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../models/work_request/create_work_request.dart';
import '../../../text/fr.dart';
import '../../../widget/time_picker/time_picker_classic.dart';
import '../../../widget/visibility/error.dart';

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

  List<DateTime>? selectedDates = [];
  int hour = -1;
  int minute = -1;
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
                onDateChanged: onDateChanged
            ),
            TimePickerClassic(
              onChangedMinute: (value) {
                setState(() {
                  if(value == ''){
                    minute = -1;
                    return;
                  }
                  minute = int.parse(value);
                });
              },
              onChangedHour: (value) {
                setState(() {
                  if(value == ''){
                    hour = -1;
                    return;
                  }
                  hour = int.parse(value);
                });
              },
            ),
            ErrorVisibility(
              errorVisibility: errorVisibility,
              errorText: AppText.createWorkRequestTimingWrong,
            ),
            const SizedBox(height: 20),
            elevatedButtonOpacityAndTextColor(
              AppColors.mainBackgroundColor,
              '${AppText.save} ${fromCalendarToString(selectedDate.day, selectedDate.month, selectedDate.year)}',
              context,
              _choseTime,
              AppColors.mainTextColor,
            ),
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

  void _choseTime(){
    
  }
}*/


import 'package:flutter/material.dart';

import '../../../models/work_request/create_work_request.dart';

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
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Time Picker Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              selectedTime != null
                  ? "Selected Time: ${selectedTime!.format(context)}"
                  : "No time selected!",
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}
