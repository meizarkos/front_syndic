class AttributesTiming {
  static const uuid = 'uuid';
  static const workRequestId =  'work_request_id';
  static const time = 'time';
  static const status = 'status';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class Timing{
  final String? uuid;
  final String? workRequestId;
  final String? time;
  final String? status;
  final String? createdAt;
  final String? updatedAt;


  const Timing({
    this.uuid,
    this.workRequestId,
    this.time,
    this.status,
    this.updatedAt,
    this.createdAt,
  });


  factory Timing.fromJson(Map<String, dynamic> json) {
    return Timing(
      uuid: json[AttributesTiming.uuid],
      workRequestId: json[AttributesTiming.workRequestId],
      time: json[AttributesTiming.time],
      status: json[AttributesTiming.status],
      updatedAt: json[AttributesTiming.updatedAt],
      createdAt: json[AttributesTiming.createdAt],
    );
  }
}
