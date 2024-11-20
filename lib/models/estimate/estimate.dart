import 'package:front_syndic/models/work_request/work_request.dart';

import '../timing/timing_estimate.dart';

class AttributesEstimate{
  static const uuid = 'uuid';
  static const price = 'price';
  static const description = 'description';
  static const commentary = 'commentary';
  static const status = 'status';
  static const workRequestId = 'work_request_id';
  static const workRequest = 'work_request';
  static const artisanId = 'artisan_id';
  static const unionId = 'union_id';
  static const councilId = 'council_id';
  static const userId = 'user_id';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class Estimate {
  final String? uuid;
  final int? price;
  final String? description;
  final String? commentary;
  final String? status;
  final List<TimingEstimate>? timingsEstimate;
  final String? workRequestId;
  final WorkRequest? workRequest;
  final String? artisanId;
  final String? unionId;
  final String? councilId;
  final String? userId;
  final String? createdAt;
  final String? updatedAt;

  const Estimate({
    this.uuid,
    this.price,
    this.description,
    this.commentary,
    this.status,
    this.timingsEstimate,
    this.workRequestId,
    this.workRequest,
    this.artisanId,
    this.unionId,
    this.councilId,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });

  factory Estimate.fromJson(Map<String, dynamic> json) {
    return Estimate(
      uuid: json[AttributesEstimate.uuid],
      price: json[AttributesEstimate.price],
      description: json[AttributesEstimate.description],
      commentary: json[AttributesEstimate.commentary],
      status: json[AttributesEstimate.status],
      timingsEstimate: (json['timing_estimates'] as List<dynamic>?)
          ?.map((timingEstimateJson) => TimingEstimate.fromJson(timingEstimateJson))
          .toList() ?? [],
      workRequestId: json[AttributesEstimate.workRequestId],
      workRequest: json[AttributesEstimate.workRequest] != null
          ? WorkRequest.fromJson(json[AttributesEstimate.workRequest])
          : null,
      artisanId: json[AttributesEstimate.artisanId],
      unionId: json[AttributesEstimate.unionId],
      councilId: json[AttributesEstimate.councilId],
      userId: json[AttributesEstimate.userId],
      updatedAt: json[AttributesEstimate.updatedAt],
      createdAt: json[AttributesEstimate.createdAt],
    );
  }
}