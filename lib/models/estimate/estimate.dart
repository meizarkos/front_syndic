import 'package:front_syndic/models/work_request/work_request.dart';

import '../timing/timing_estimate.dart';

class AttributesEstimate{
  static const uuid = 'uuid';
  static const price = 'price';
  static const description = 'description';
  static const commentary = 'commentary';
  static const status = 'status';
  static const statusGoal = 'status_goal';
  static const workRequestId = 'work_request_id';
  static const workRequest = 'work_request';
  static const conversationId = 'conversation_id';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class Estimate {
  String? uuid;
  double? price;
  String? description;
  String? commentary;
  int? status;
  int? statusGoal;
  List<TimingEstimate>? timingsEstimate;
  String? workRequestId;
  WorkRequest? workRequest;
  String? conversationId;
  String? createdAt;
  String? updatedAt;

  Estimate({
    this.uuid,
    this.price,
    this.description,
    this.commentary,
    this.status,
    this.statusGoal,
    this.timingsEstimate,
    this.workRequestId,
    this.workRequest,
    this.conversationId,
    this.updatedAt,
    this.createdAt,
  });

  factory Estimate.fromJson(Map<String, dynamic> json) {
    return Estimate(
      uuid: json[AttributesEstimate.uuid],
      price: json[AttributesEstimate.price]?.toDouble(),
      description: json[AttributesEstimate.description],
      commentary: json[AttributesEstimate.commentary],
      status: json[AttributesEstimate.status],
      statusGoal: json[AttributesEstimate.statusGoal],
      timingsEstimate: (json['timing_estimates'] as List<dynamic>?)
          ?.map((timingEstimateJson) => TimingEstimate.fromJson(timingEstimateJson))
          .toList() ?? [],
      workRequestId: json[AttributesEstimate.workRequestId],
      workRequest: json[AttributesEstimate.workRequest] != null
          ? WorkRequest.fromJson(json[AttributesEstimate.workRequest])
          : null,
      conversationId: json[AttributesEstimate.conversationId],
      updatedAt: json[AttributesEstimate.updatedAt],
      createdAt: json[AttributesEstimate.createdAt],
    );
  }
}