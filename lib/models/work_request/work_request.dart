import 'dart:ffi';

class AttributesWorkRequest{
  static const uuid = 'uuid';
  static const category = 'category';
  static const title = 'title';
  static const description = 'description';
  static const interventionDate = 'intervention_date';
  static const status = 'status';
  static const numberOfEstimate = 'number_of_estimate';
  static const coOwnerId =  'co_owner_id';
// static const appartments_id = 'appartments_id';
  static const updatedAt = 'upadated_at';
  static const createdAt = 'created_at';
}

class WorkRequest{
  final String? uuid;
  final String? category;
  final String? title;
  final String? description;
  final String? interventionDate;
  final String? status;
  final Int? numberOfEstimate;
  final String? coOwnerId;
  final String? updatedAt;
  final String? createdAt;

  const WorkRequest({
    this.uuid,
    this.category,
    this.title,
    this.description,
    this.interventionDate,
    this.status,
    this.numberOfEstimate,
    this.coOwnerId,
    this.updatedAt,
    this.createdAt,
  });

  factory WorkRequest.fromJson(Map<String, dynamic> json) {
    return WorkRequest(
      uuid: json[AttributesWorkRequest.uuid],
      category: json[AttributesWorkRequest.category],
      title: json[AttributesWorkRequest.title],
      description: json[AttributesWorkRequest.description],
      interventionDate: json[AttributesWorkRequest.interventionDate],
      status: json[AttributesWorkRequest.status],
      numberOfEstimate: json[AttributesWorkRequest.numberOfEstimate],
      coOwnerId: json[AttributesWorkRequest.coOwnerId],
      updatedAt: json[AttributesWorkRequest.updatedAt],
      createdAt: json[AttributesWorkRequest.createdAt],
    );
  }
}
