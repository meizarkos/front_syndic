import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../models/timing/timing_estimate.dart';
import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../utils/string_handler/handle_string.dart';

class CreateTimingEstimate extends StatefulWidget {
  const CreateTimingEstimate({
    super.key,
    required this.timingEstimate,
    required this.onBack,
    required this.onRegister,
  });

  final TimingEstimate timingEstimate;
  final Function() onBack; //must be a pushReplacement
  final Future<void> Function(TimingEstimate)
      onRegister; //must be a pushReplacement

  @override
  State<CreateTimingEstimate> createState() => _CreateTimingEstimateState();
}

class _CreateTimingEstimateState extends State<CreateTimingEstimate> {
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  DateTime selectedDate = DateTime.now();
  DateTime selectedDateEnd = DateTime.now();
  TimeOfDay? selectedTime;

  Key calendarKey = UniqueKey();
  bool showDateEnd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: widget.onBack,
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppText.dateAndHourOfStart,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 15),
            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: firstDate,
              lastDate: lastDate,
              onDateChanged: onDateChanged,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _choseTime,
              child: Text(
                '${AppText.createWorkRequestTiming} ${fromCalendarToString(selectedDate.day, selectedDate.month, selectedDate.year)}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 35),
            Text(
              _noDateOrTime(),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 35),
            Visibility(
              visible: showDateEnd,
              child: Column(
                children: [
                  Text(
                    AppText.dateOfEnd,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 15),
                  CalendarDatePicker(
                    key: calendarKey,
                    initialDate: selectedDateEnd,
                    firstDate: selectedDate,
                    lastDate: lastDate,
                    onDateChanged: onDateEndChanged,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    _noDateEnd(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 35),
                  elevatedButtonAndTextColor(
                    AppColors.mainBackgroundColor,
                    AppText.save,
                    context,
                    () => widget.onRegister(widget.timingEstimate),
                    AppColors.mainTextColor,
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
      if (selectedDateEnd.isBefore(selectedDate)) {
        selectedDateEnd = selectedDate;
      }
      calendarKey = UniqueKey();
      widget.timingEstimate.dateStart =
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      widget.timingEstimate.dateEnd = '${date.year}-${date.month}-${date.day}';
    });
  }

  void onDateEndChanged(DateTime date) {
    setState(() {
      selectedDateEnd = date;
      widget.timingEstimate.dateEnd = '${selectedDateEnd.year}-${selectedDateEnd.month}-${selectedDateEnd.day}';
    });
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
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      widget.timingEstimate.timeStart =
          '${selectedDate.hour}:${selectedDate.minute}';
      widget.timingEstimate.dateStart =
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
      showDateEnd = true;
    });
  }

  String _noDateOrTime() {
    if (widget.timingEstimate.dateStart == null ||
        widget.timingEstimate.timeStart == null) {
      return AppText.noDateForWork;
    }
    return '${AppText.createEstimateTimingTextChoice} ${toLowerFirst(AppText.le)} ${formatStringToApiDate(widget.timingEstimate.dateStart, 'dd/MM/yyyy')} ${AppText.at} ${formatTimeString(widget.timingEstimate.timeStart)}';
  }

  String _noDateEnd() {
    if (widget.timingEstimate.dateEnd == null) {
      return AppText.noDateForWork;
    }
    return '${AppText.createEstimateTimingTextChoice} ${toLowerFirst(AppText.le)} ${formatStringToApiDate(widget.timingEstimate.dateEnd, 'dd/MM/yyyy')}';
  }
}
