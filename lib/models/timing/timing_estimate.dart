import 'package:front_syndic/models/estimate/estimate.dart';
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
  static const estimate = 'estimate';
  static const estimateId =  'estimate_id';
  static const conversationId = 'conversation_id';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class TimingEstimate{
   String? uuid;
   String? dateStart;
   String? timeStart;
   String? dateEnd;
   int? status;
   int? statusGoal;
   String? workRequestId;
   WorkRequest? workRequest;
   String? estimateId;
   String? conversationId;
   String? createdAt;
   String? updatedAt;
   Estimate? estimate;


  TimingEstimate({
    this.uuid,
    this.dateStart,
    this.timeStart,
    this.dateEnd,
    this.status,
    this.statusGoal,
    this.workRequestId,
    this.workRequest,
    this.estimate,
    this.estimateId,
    this.conversationId,
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
      estimate: json[AttributesTimingEstimate.estimate] != null ? Estimate.fromJson(json[AttributesTimingEstimate.estimate]) : null,
      estimateId: json[AttributesTimingEstimate.estimateId],
      conversationId: json[AttributesTimingEstimate.conversationId],
      updatedAt: json[AttributesTimingEstimate.updatedAt],
      createdAt: json[AttributesTimingEstimate.createdAt],
    );
  }
}
