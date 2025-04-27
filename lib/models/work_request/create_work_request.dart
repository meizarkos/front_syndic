import 'package:flutter/material.dart';
import 'package:front_syndic/models/work_request/work_request.dart';

import '../adress/adress.dart';

class CreateWorkRequest {
  List<Image> images = [];
  WorkRequest workRequest;
  Adress adress;
  CreateWorkRequest(this.images,this.workRequest,this.adress);
}