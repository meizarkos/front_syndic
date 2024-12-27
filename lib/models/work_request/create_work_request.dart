import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_syndic/models/work_request/work_request.dart';

import '../adress/adress.dart';

class CreateWorkRequest {
  List<Image> images = [];
  WorkRequest workRequest;
  CameraDescription? camera;
  Adress adress;
  CreateWorkRequest(this.images,this.workRequest,this.camera,this.adress);
}