import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/timing/get_timings.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/utils/date_to_string/date.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../../models/timing/timing.dart';
import '../../../../text/fr.dart';
import '../../../../widget/visibility/error.dart';
import '../../../api_handler/timing/patch_timing_of_work_request.dart';
import '../create_work_request/chose_time/cell_time.dart';

class RecapTimingChange extends StatefulWidget {
  const RecapTimingChange({
    super.key,
    required this.uuid,
  });

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

  bool isLoading = true;
  bool apiErrorVisibility = false;
  bool errorVisibility = false;
  bool successVisibility = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: appBarBackButton(context),
        body: Column(
          children: [
            ErrorVisibility(
                errorVisibility: apiErrorVisibility,
                errorText: AppText.apiErrorText),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: appBarBackButton(context,
            title: AppText.createWorkRequestInterventionDate),
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
                  '${AppText.createWorkRequestTiming} ${fromCalendarToString(
                      selectedDate.day, selectedDate.month,
                      selectedDate.year)}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelSmall,
                ),
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
              elevatedButtonAndTextColor(
                AppColors.mainBackgroundColor,
                AppText.save,
                context,
                _onSave,
                AppColors.mainTextColor,
              ),
              const SizedBox(height: 20),
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
            ],
          ),
        ),
      );
    }
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
    patchTimingFromWorkRequest(widget.uuid, timings);
    setState(() {
      successVisibility = true;
      errorVisibility = false;
    });
  }

  Future<void> fetchData() async {
    try {
      timings = await fetchTimingFromWorkRequest(widget.uuid);
      if (timings == null) {
        apiErrorVisibility = true;
        return;
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      apiErrorVisibility = true;
    }
  }
}
