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

String fromCalendarToString(int day, int month, int year){
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