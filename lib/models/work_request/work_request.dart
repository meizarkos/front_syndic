import 'package:front_syndic/models/timing/timing.dart';

class AttributesWorkRequest{
  static const uuid = 'uuid';
  static const category = 'category';
  static const title = 'title';
  static const description = 'description';
  static const status = 'status';
  static const numberOfEstimate = 'number_of_estimate';
  static const coOwnerId =  'co_owner_id';
// static const appartments_id = 'appartments_id';
  static const updatedAt = 'upadated_at';
  static const createdAt = 'created_at';
}

class WorkRequest{
  String? uuid;
 String? category;
 String? title;
 String? description;
 String? status;
 int? numberOfEstimate;
 List<Timing>? timings;
 String? coOwnerId;
 String? updatedAt;
 String? createdAt;

  WorkRequest({
    this.uuid,
    this.category,
    this.title,
    this.description,
    this.status,
    this.numberOfEstimate,
    this.timings,
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
      status: json[AttributesWorkRequest.status],
      numberOfEstimate: json[AttributesWorkRequest.numberOfEstimate],
      timings: (json['timings'] as List<dynamic>)
          .map((timingJson) => Timing.fromJson(timingJson))
          .toList(),
      coOwnerId: json[AttributesWorkRequest.coOwnerId],
      updatedAt: json[AttributesWorkRequest.updatedAt],
      createdAt: json[AttributesWorkRequest.createdAt],
    );
  }
}
