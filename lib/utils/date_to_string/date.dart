import 'package:front_syndic/text/fr.dart';
import 'package:intl/intl.dart';

class DateErrorStrings {
  static const noDateFound = "No date found";
}

class AllMonthStrings {
  static const months = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];
}

String fromDateToStringLong(String? date){
  if(date == null){
    return DateErrorStrings.noDateFound;
  }
  final year = date.substring(0, 4);
  var month = AllMonthStrings.months[int.parse(date.substring(5, 7))-1];
  if(month.length < 2){
    month = "0$month";
  }
  var day = date.substring(8, 10);
  if(day.length < 2){
    day = "0$day";
  }
  return "$day $month $year";
}

String? fromStringToStringDate(String? date){
  try{
    if(date == null){
      return DateErrorStrings.noDateFound;
    }
    var year = date.substring(0, 4);
    var month = date.substring(5, 7);
    if(month.length < 2){
      month = "0$month";
    }
    var day = date.substring(8, 10);
    if(day.length < 2){
      day = "0$day";
    }
    return "$day/$month/$year";
  }
  catch(e){
    return null;
  }
}

String? fromStringToDateTimeString(String? date){
  final dateLocal = fromStringToStringDate(date);
  if(dateLocal == null){
    return DateErrorStrings.noDateFound;
  }
  final time = date?.substring(11, 16);
  return "$dateLocal ${AppText.at} $time";
}

String fromCalendarToString(int day, int month, int year){
  try{
    var monthString = month.toString();
    if(month.toString().length < 2){
      monthString = "0$month";
    }
    var dayString = day.toString();
    if(day.toString().length < 2){
      dayString = "0$day";
    }
    return "$dayString/$monthString/$year";
  }
  catch(e){
    return DateErrorStrings.noDateFound;
  }
}

String fromDateTimeToStringShort(DateTime? date){
  if(date == null){
    return DateErrorStrings.noDateFound;
  }
  var year = date.year.toString();
  var month = date.month.toString();
  if(month.length < 2){
    month = "0$month";
  }
  var day = date.day.toString();
  if(day.length < 2){
    day = "0$day";
  }
  return "$day/$month/$year";
}

String fromDateTimeToStringLong(DateTime? date){
  if(date == null){
    return DateErrorStrings.noDateFound;
  }
  final year = date.year.toString();
  var month = AllMonthStrings.months[int.parse(date.month.toString())-1];
  if(month.length < 2){
    month = "0$month";
  }
  var day = date.day.toString();
  if(day.length < 2){
    day = "0$day";
  }
  return "$day $month $year";
}

String fromDateTimeToStringForApi(DateTime? date){
  if(date == null){
    return DateErrorStrings.noDateFound;
  }
  var year = date.year.toString();
  var month = date.month.toString();
  if(month.length < 2){
    month = "0$month";
  }
  var day = date.day.toString();
  if(day.length < 2){
    day = "0$day";
  }
  return "$month/$day/$year";
}

String? formatStringToApiDate(String? dateString,String formatExit){
  if(dateString == null){
    return null;
  }
  DateTime? parsedDate;
  List<String> formats = ["yyyy-M-d", "yyyy-MM-dd","yyyy-MM-d", "yyyy-M-dd"];
  for (String format in formats) {
    try {
      parsedDate = DateFormat(format).parseStrict(dateString);
      break;
    } catch (e) {
      continue;
    }
  }

  if (parsedDate == null) {
    return "Invalid date format";
  }

  return DateFormat(formatExit).format(parsedDate);
}


String formatTimeString(String? timeString) {
  if(timeString == null){
    return DateErrorStrings.noDateFound;
  }
  DateTime? parsedTime;
  List<String> formats = ["HH:mm", "H:m", "HH:m", "H:mm",'HH:mm:ss']; // Define possible time formats

  for (String format in formats) {
    try {
      parsedTime = DateFormat(format).parseStrict(timeString);
      break;
    } catch (e) {
      continue;
    }
  }

  if (parsedTime == null) {
    return "Invalid time format";
  }

  return DateFormat("HH : mm").format(parsedTime).replaceAll(':', 'h'); // Convert to desired time format
}

String formatTimeStringForApi(String? timeString, String formatExit) {
  if(timeString == null){
    return DateErrorStrings.noDateFound;
  }
  DateTime? parsedTime;
  List<String> formats = ["HH:mm", "H:m", "HH:m", "H:mm",'HH:mm:ss']; // Define possible time formats

  for (String format in formats) {
    try {
      parsedTime = DateFormat(format).parseStrict(timeString);
      break;
    } catch (e) {
      continue;
    }
  }

  if (parsedTime == null) {
    return "Invalid time format";
  }

  return DateFormat(formatExit).format(parsedTime);
}

String fromDateTimeToConvString(String? date){
  if(date == null){
    return DateErrorStrings.noDateFound;
  }
  DateTime? parsedDate;
  try {
    parsedDate =DateTime.parse(date);
  } catch (e) {
    return 'NN';
  }

  return DateFormat("dd/MM HH:mm").format(parsedDate);

}