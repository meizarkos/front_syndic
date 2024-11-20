import 'package:front_syndic/models/artisan/artisan.dart';
import 'package:front_syndic/models/council/council.dart';
import 'package:front_syndic/models/work_request/work_request.dart';

import '../union/union.dart';

class AttributesTiming {
  static const uuid = 'uuid';
  static const date = 'time';
  static const time = 'time_hour';
  static const status = 'status';
  static const workRequestId =  'work_request_id';
  static const workRequest = 'work_request';
  static const artisanId = 'artisan_id';
  static const artisan = 'artisan';
  static const councilId = 'council_id';
  static const council = 'council';
  static const unionId = 'union_id';
  static const union = 'union';
  static const userId = 'user_id';
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
   String? artisanId;
   Artisan? artisan;
   String? councilId;
   Council? council;
   String? unionId;
   UnionApi? union;
   String? userId;
   String? createdAt;
   String? updatedAt;


  Timing({
    this.uuid,
    this.date,
    this.time,
    this.status,
    this.workRequestId,
    this.workRequest,
    this.artisanId,
    this.artisan,
    this.councilId,
    this.council,
    this.unionId,
    this.union,
    this.userId,
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
      artisanId: json[AttributesTiming.artisanId],
      artisan: json[AttributesTiming.artisan] != null ? Artisan.fromJson(json[AttributesTiming.artisan]) : null,
      councilId: json[AttributesTiming.councilId],
      council: json[AttributesTiming.council] != null ? Council.fromJson(json[AttributesTiming.council]) : null,
      unionId: json[AttributesTiming.unionId],
      union: json[AttributesTiming.union] != null ? UnionApi.fromJson(json[AttributesTiming.union]) : null,
      userId: json[AttributesTiming.userId],
      updatedAt: json[AttributesTiming.updatedAt],
      createdAt: json[AttributesTiming.createdAt],
    );
  }
}
