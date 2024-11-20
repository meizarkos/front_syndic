import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';

String getTitleWorkRequest(dynamic data){
  return data.workRequest?.title ?? AppText.noTitleForWork;
}

String getTitleAndAddPrefix(dynamic data){
  return '${AppText.for_} ${getTitleWorkRequest(data)}';
}

String getMessage(dynamic data){
  return data.message ?? AppText.messageNoMessage;
}

String getDateOfMessage(dynamic data){
  final createdAt = data.createdAt;
  if(createdAt == null){
    return AppText.noDate;
  }
  final date = createdAt.split('T');
  return '${AppText.le} ${formatStringToApiDate(date[0],'dd/MM')} ${AppText.at} ${date[1].substring(0,5)}';
}

String getDateMeeting(dynamic data){
  final date = data.date;
  final time = data.time;
  if(date == null || time == null){
    return AppText.noDate;
  }

  return '${AppText.timing} ${AppText.le} ${formatStringToApiDate(date,'dd/MM')} ${AppText.at} ${time.substring(0,5)}';
}

String getDateMeetingEstimate(dynamic data){
  final date = data.dateStart;
  final time = data.timeStart;
  final dateEnd = data.dateEnd;
  if(date == null || time == null || dateEnd == null){
    return AppText.noDate;
  }

  return '${AppText.timingEstimateListTitle} ${formatStringToApiDate(date,'dd/MM')} ${AppText.at} ${time.substring(0,5)}.'
      ' ${AppText.to} ${formatStringToApiDate(dateEnd,'dd/MM/yyyy')}';
}

String getPriceEstimate(dynamic data){
  if(data.price != null){
    return '${data.price} ${AppText.euro}';
  }
  return AppText.noPriceEstimate;
}

String getEstimateDesc(dynamic data){
  return data.description ?? AppText.noDescriptionWorkRequest;
}
