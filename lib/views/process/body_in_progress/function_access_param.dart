import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';

String getTitleWorkRequest(dynamic data){
  return data.workRequest?.title ?? AppText.noTitleForWork;
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
