import 'package:flutter/cupertino.dart';

class CouncilWorkRequestDetail{
  String uuid;
  Function(String?) futureToFetchData;
  VoidCallback onGoBack;


  CouncilWorkRequestDetail({
    required this.uuid,
    required this.futureToFetchData,
    required this.onGoBack,
  });
}