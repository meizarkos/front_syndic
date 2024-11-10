import 'package:flutter/material.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';

import '../../../api_handler/timing/post_meeting_artisan.dart';
import '../../../color.dart';
import '../../../models/timing/timing.dart';
import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/header/app_bar_back_button.dart';

class PostMeetingWorkRequest extends StatefulWidget {
  const PostMeetingWorkRequest({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  State<PostMeetingWorkRequest> createState() => _PostMeetingWorkRequestState();
}

class _PostMeetingWorkRequestState extends State<PostMeetingWorkRequest> {

  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365));
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  Timing timing = Timing();

  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppText.createWorkRequestInterventionDate,
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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _choseTime,
              child: Text(
                '${AppText.createWorkRequestTiming} ${fromCalendarToString(selectedDate.day, selectedDate.month, selectedDate.year)}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 35),
            elevatedButtonOpacityAndTextColor(
              AppColors.mainBackgroundColor,
              _noDateOrTime(),
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

  void _onSave()async{
    await postTimingFromWorkRequestArtisan(widget.uuid, timing);
    Navigator.pop(context);
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
      setState(() {
        timing =  Timing(
          date: '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
          time: '${selectedDate.hour}:${selectedDate.minute}',
        );
      });
    });
  }

  String _noDateOrTime(){
    if(timing.date == null || timing.time == null){
      return AppText.noDateForWork;
    }
    return '${AppText.save} ${AppText.le} ${formatStringToApiDate(timing.date,'dd/MM/yyyy')} ${AppText.at} ${formatTimeString(timing.time)}';
  }
}
