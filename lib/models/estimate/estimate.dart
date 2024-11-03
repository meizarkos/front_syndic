import '../timing/timing_estimate.dart';

class AttributesEstimate{
  static const uuid = 'uuid';
  static const workRequestId = 'work_request_id';
  static const artisanId = 'artisan_id';
  static const price = 'price';
  static const description = 'description';
  static const commentary = 'commentary';
  static const status = 'status';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class Estimate {
  final String? uuid;
  final String? workRequestId;
  final String? artisanId;
  final String? price;
  final String? description;
  final String? commentary;
  final String? status;
  final List<TimingEstimate>? timingsEstimate;
  final String? createdAt;
  final String? updatedAt;

  const Estimate({
    this.uuid,
    this.workRequestId,
    this.artisanId,
    this.price,
    this.description,
    this.commentary,
    this.status,
    this.timingsEstimate,
    this.updatedAt,
    this.createdAt,
  });

  factory Estimate.fromJson(Map<String, dynamic> json) {
    return Estimate(
      uuid: json[AttributesEstimate.uuid],
      workRequestId: json[AttributesEstimate.workRequestId],
      artisanId: json[AttributesEstimate.artisanId],
      price: json[AttributesEstimate.price],
      description: json[AttributesEstimate.description],
      commentary: json[AttributesEstimate.commentary],
      status: json[AttributesEstimate.status],
      timingsEstimate: (json['timing_estimates'] as List<dynamic>?)
          ?.map((timingEstimateJson) => TimingEstimate.fromJson(timingEstimateJson))
          .toList() ?? [],
      updatedAt: json[AttributesEstimate.updatedAt],
      createdAt: json[AttributesEstimate.createdAt],
    );
  }
}