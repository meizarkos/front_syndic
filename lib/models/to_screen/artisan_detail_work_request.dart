import '../work_request/work_request.dart';

class ArtisanWorkRequestDetailArg{
  final Future<WorkRequest?> Function(String?) futureToFetchData;
  final String? workRequestUuid;
  final bool showContact;

  ArtisanWorkRequestDetailArg({
    required this.futureToFetchData,
    required this.workRequestUuid,
    required this.showContact,
  });
}