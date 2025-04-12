
import 'package:front_syndic/models/artisan/artisan.dart';
import 'package:front_syndic/models/council/council.dart';
import 'package:front_syndic/models/union/union.dart';
import 'package:front_syndic/models/work_request/work_request.dart';

import '../user/user.dart';

class AttributesTiming {
  static const uuid = 'uuid';
  static const date = 'time';
  static const time = 'time_hour';
  static const status = 'status';
  static const workRequestId =  'work_request_id';
  static const workRequest = 'work_request';
  static const convId = 'conversation_id';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class Timing{
   String? uuid;
   String? date;
   String? time;
   String? status;
   String? workRequestId;
   WorkRequest? workRequest;
   String? convId;
   String? createdAt;
   String? updatedAt;


  Timing({
    this.uuid,
    this.date,
    this.time,
    this.status,
    this.workRequestId,
    this.workRequest,
    this.convId,
    this.updatedAt,
    this.createdAt,
  });


  factory Timing.fromJson(Map<String, dynamic> json) {
    return Timing(
      uuid: json[AttributesTiming.uuid],
      date: json[AttributesTiming.date],
      time: json[AttributesTiming.time],
      status: json[AttributesTiming.status],
      workRequestId: json[AttributesTiming.workRequestId],
      workRequest : json[AttributesTiming.workRequest] != null ? WorkRequest.fromJson(json[AttributesTiming.workRequest]) : null,
      convId: json[AttributesTiming.convId],
      updatedAt: json[AttributesTiming.updatedAt],
      createdAt: json[AttributesTiming.createdAt],
    );
  }
}


class TimingAndCreator{
  Timing? timing;
  Artisan? artisan;
  UnionApi? union;
  Council? council;
  User? user;

  TimingAndCreator(this.timing, this.artisan, this.union, this.council, this.user);
}
