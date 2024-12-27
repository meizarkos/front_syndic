import 'package:front_syndic/models/adress/adress.dart';
import 'package:front_syndic/models/timing/timing.dart';

class AttributesWorkRequest {
  static const uuid = 'uuid';
  static const category = 'category';
  static const title = 'title';
  static const description = 'description';
  static const status = 'status';
  static const numberOfEstimate = 'number_of_estimate';
  static const adress = 'adress';
  static const councilId = 'council_id';
  static const unionId = 'union_id';
  static const userId = 'user_id';
  static const adressId = 'adress_id';
  static const updatedAt = 'upadated_at';
  static const createdAt = 'created_at';
}

class WorkRequest {
  String? uuid;
  String? category;
  String? title;
  String? description;
  String? status;
  int? numberOfEstimate;
  List<Timing>? timings;
  Adress? adress;
  String? councilId;
  String? unionId;
  String? userId;
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
    this.adress,
    this.councilId,
    this.unionId,
    this.userId,
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
      timings: (json['timings'] as List<dynamic>?)
          ?.map((timingJson) => Timing.fromJson(timingJson))
          .toList() ?? [],
      adress: json.containsKey(AttributesWorkRequest.adress) && json[AttributesWorkRequest.adress] != null
          ? Adress.fromJson(json[AttributesWorkRequest.adress])
          : null,
      councilId: json[AttributesWorkRequest.councilId],
      unionId: json[AttributesWorkRequest.unionId],
      userId: json[AttributesWorkRequest.userId],
      updatedAt: json[AttributesWorkRequest.updatedAt],
      createdAt: json[AttributesWorkRequest.createdAt],
    );
  }
}
