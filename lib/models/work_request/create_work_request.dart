import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_syndic/models/work_request/work_request.dart';

class CreateWorkRequest {
  List<Image> images = [];
  WorkRequest workRequest;
  CameraDescription? camera;
  CreateWorkRequest(this.images,this.workRequest,this.camera);
}