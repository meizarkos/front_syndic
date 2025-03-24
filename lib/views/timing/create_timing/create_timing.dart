import 'package:flutter/material.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../color.dart';
import '../../../core_value.dart';
import '../../../models/timing/timing.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/visibility/error.dart';

class CreateTiming extends StatefulWidget {
  const CreateTiming({
    super.key,
    required this.futureCreateMeeting,
    required this.convUuid,
    required this.routeToConv,
  });

  final Future<void> Function(String?, Timing) futureCreateMeeting;
  final Function() routeToConv;
  final String? convUuid;

  @override
  State<CreateTiming> createState() => _CreateTimingState();
}

class _CreateTimingState extends State<CreateTiming> {
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  Timing timing = Timing();
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.createAMeeting),
      body: Column(
        children: [
          const SizedBox(height: AppUIValue.spaceScreenToAny),
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
          const SizedBox(height: AppUIValue.spaceScreenToAny),
          Text(
            textToDisplay(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: AppUIValue.spaceScreenToAny),
          elevatedButtonAndTextColor(
            AppColors.mainBackgroundColor,
            AppText.save,
            context,
            _onSave,
            AppColors.mainTextColor,
          ),
        ],
      ),
    );
  }

  String textToDisplay(){
    if(timing.date == null || timing.time == null){
      return AppText.noTimingSelection;
    }
    return '${AppText.timingSelection} ${formatStringToApiDate(timing.date,'dd/MM/yyyy')} ${AppText.at} ${timing.time}';
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
      timing.date = formatStringToApiDate('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}', 'yyyy-MM-dd');
      timing.time = formatTimeStringForApi('${selectedDate.hour}:${selectedDate.minute}', 'HH:mm');
    });
  }

  void _onSave() async {
    if (timing.date == null || timing.time == null) {
      setState(() {
        errorVisibility = true;
      });
      return;
    }
    await widget.futureCreateMeeting(widget.convUuid, timing);
    widget.routeToConv();
  }
}
