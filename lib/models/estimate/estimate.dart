class AttributesEstimate{
  static const uuid = 'uuid';
  static const workRequestId = 'work_request_id';
  static const artisanId = 'artisan_id';
  static const price = 'price';
  static const interventionDateStart = 'intervention_date_start';
  static const interventionDateEnd = 'intervention_date_end';
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
  final String? interventionDateStart;
  final String? interventionDateEnd;
  final String? description;
  final String? commentary;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  const Estimate({
    this.uuid,
    this.workRequestId,
    this.artisanId,
    this.price,
    this.interventionDateStart,
    this.interventionDateEnd,
    this.description,
    this.commentary,
    this.status,
    this.updatedAt,
    this.createdAt,
  });

  factory Estimate.fromJson(Map<String, dynamic> json) {
    return Estimate(
      uuid: json[AttributesEstimate.uuid],
      workRequestId: json[AttributesEstimate.workRequestId],
      artisanId: json[AttributesEstimate.artisanId],
      price: json[AttributesEstimate.price],
      interventionDateStart: json[AttributesEstimate.interventionDateStart],
      interventionDateEnd: json[AttributesEstimate.interventionDateEnd],
      description: json[AttributesEstimate.description],
      commentary: json[AttributesEstimate.commentary],
      status: json[AttributesEstimate.status],
      updatedAt: json[AttributesEstimate.updatedAt],
      createdAt: json[AttributesEstimate.createdAt],
    );
  }
}