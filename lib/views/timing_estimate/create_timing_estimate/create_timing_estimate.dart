import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../core_value.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              Text(
                AppText.dateAndHourOfStart,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: firstDate,
                lastDate: lastDate,
                onDateChanged: onDateChanged,
              ),
              const SizedBox(height: 35),
              Text(
                _noDateOrTime(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Divider(
                color: Colors.black,
                thickness: 2,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
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
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 35),
                    elevatedButtonAndTextColor(
                      AppColors.mainBackgroundColor,
                      AppText.save,
                      context,
                      () {
                        widget.timingEstimate.dateStart = formatStringToApiDate(widget.timingEstimate.dateStart, 'yyyy-MM-dd');
                        widget.timingEstimate.dateEnd = formatStringToApiDate(widget.timingEstimate.dateEnd, 'yyyy-MM-dd');
                        if(widget.timingEstimate.dateStart == null || widget.timingEstimate.dateEnd == null){
                          return;
                        }
                        widget.onRegister(widget.timingEstimate);
                      },
                      AppColors.mainTextColor,
                    ),
                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ],
          ),
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

      String? formatDateStart = formatStringToApiDate(widget.timingEstimate.dateStart, 'yyyy-MM-dd');
      String? formatDateEnd = formatStringToApiDate(widget.timingEstimate.dateEnd, 'yyyy-MM-dd');

      if(formatDateStart != null && formatDateEnd != null){
        DateTime dateStartDateTime = DateTime.parse(formatDateStart);
        DateTime dateEndDateTime = DateTime.parse(formatDateEnd);
        if(dateEndDateTime.isBefore(dateStartDateTime)){
          widget.timingEstimate.dateEnd = widget.timingEstimate.dateStart;
        }
      }
      else{
        widget.timingEstimate.dateEnd = widget.timingEstimate.dateStart;
      }
    });
    _choseTime();
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
      setState(() {
        widget.timingEstimate.dateEnd = widget.timingEstimate.dateStart;
      });
    }
    return '${AppText.createEstimateTimingTextChoice} ${toLowerFirst(AppText.le)} ${formatStringToApiDate(widget.timingEstimate.dateEnd, 'dd/MM/yyyy')}';
  }
}
