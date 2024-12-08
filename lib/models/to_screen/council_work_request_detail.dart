import 'package:flutter/cupertino.dart';

class CouncilWorkRequestDetail{
  String uuid;
  Function(String?) futureToFetchData;
  VoidCallback onBack;
  Function(String?) onDelete;


  CouncilWorkRequestDetail({
    required this.uuid,
    required this.futureToFetchData,
    required this.onBack,
    required this.onDelete,
  });
}