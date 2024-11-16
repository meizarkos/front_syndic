class AttributesTiming {
  static const uuid = 'uuid';
  static const date = 'time';
  static const time = 'time_hour';
  static const status = 'status';
  static const workRequestId =  'work_request_id';
  static const artisanId = 'artisan_id';
  static const councilId = 'council_id';
  static const unionId = 'union_id';
  static const userId = 'user_id';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class Timing{
   String? uuid;
   String? date;
   String? time;
   String? status;
   String? workRequestId;
   String? artisanId;
   String? councilId;
   String? unionId;
   String? userId;
   String? createdAt;
   String? updatedAt;


  Timing({
    this.uuid,
    this.date,
    this.time,
    this.status,
    this.workRequestId,
    this.artisanId,
    this.councilId,
    this.unionId,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });


  factory Timing.fromJson(Map<String, dynamic> json) {
    return Timing(
      uuid: json[AttributesTiming.uuid],
      date: json[AttributesTiming.date],
      time: json[AttributesTiming.time],
      status: json[AttributesTiming.status],
      workRequestId: json[AttributesTiming.workRequestId],
      artisanId: json[AttributesTiming.artisanId],
      councilId: json[AttributesTiming.councilId],
      unionId: json[AttributesTiming.unionId],
      userId: json[AttributesTiming.userId],
      updatedAt: json[AttributesTiming.updatedAt],
      createdAt: json[AttributesTiming.createdAt],
    );
  }
}
