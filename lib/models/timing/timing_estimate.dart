import 'package:front_syndic/models/work_request/work_request.dart';

class AttributesTimingEstimate {
  static const uuid = 'uuid';
  static const dateStart = 'date_start';
  static const timeStart = 'time_start';
  static const dateEnd = 'date_end';
  static const status = 'status';
  static const statusGoal = 'status_goal';
  static const workRequestId = 'work_request_id';
  static const workRequest = 'work_request';
  static const estimateId =  'estimate_id';
  static const artisanId = 'artisan_id';
  static const councilId = 'council_id';
  static const unionId = 'union_id';
  static const userId = 'user_id';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class TimingEstimate{
  final String? uuid;
  final String? dateStart;
  final String? timeStart;
  final String? dateEnd;
  final int? status;
  final int? statusGoal;
  final String? workRequestId;
  final WorkRequest? workRequest;
  final String? estimateId;
  final String? artisanId;
  final String? councilId;
  final String? unionId;
  final String? userId;
  final String? createdAt;
  final String? updatedAt;


  const TimingEstimate({
    this.uuid,
    this.dateStart,
    this.timeStart,
    this.dateEnd,
    this.status,
    this.statusGoal,
    this.workRequestId,
    this.workRequest,
    this.estimateId,
    this.artisanId,
    this.councilId,
    this.unionId,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });


  factory TimingEstimate.fromJson(Map<String, dynamic> json) {
    return TimingEstimate(
      uuid: json[AttributesTimingEstimate.uuid],
      dateStart: json[AttributesTimingEstimate.dateStart],
      timeStart: json[AttributesTimingEstimate.timeStart],
      dateEnd: json[AttributesTimingEstimate.dateEnd],
      status: json[AttributesTimingEstimate.status],
      statusGoal: json[AttributesTimingEstimate.statusGoal],
      workRequestId: json[AttributesTimingEstimate.workRequestId],
      workRequest : json[AttributesTimingEstimate.workRequest] != null ? WorkRequest.fromJson(json[AttributesTimingEstimate.workRequest]) : null,
      estimateId: json[AttributesTimingEstimate.estimateId],
      artisanId: json[AttributesTimingEstimate.artisanId],
      councilId: json[AttributesTimingEstimate.councilId],
      unionId: json[AttributesTimingEstimate.unionId],
      userId: json[AttributesTimingEstimate.userId],
      updatedAt: json[AttributesTimingEstimate.updatedAt],
      createdAt: json[AttributesTimingEstimate.createdAt],
    );
  }
}
