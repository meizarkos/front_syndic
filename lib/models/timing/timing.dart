class AttributesTiming {
  static const uuid = 'uuid';
  static const workRequestId =  'work_request_id';
  static const artisanId = 'artisan_id';
  static const date = 'time';
  static const time = 'time_hour';
  static const status = 'status';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class Timing{
   String? uuid;
   String? workRequestId;
   String? artisanId;
   String? date;
   String? time;
   String? status;
   String? createdAt;
   String? updatedAt;


  Timing({
    this.uuid,
    this.workRequestId,
    this.artisanId,
    this.date,
    this.time,
    this.status,
    this.updatedAt,
    this.createdAt,
  });


  factory Timing.fromJson(Map<String, dynamic> json) {
    return Timing(
      uuid: json[AttributesTiming.uuid],
      workRequestId: json[AttributesTiming.workRequestId],
      artisanId: json[AttributesTiming.artisanId],
      date: json[AttributesTiming.date],
      time: json[AttributesTiming.time],
      status: json[AttributesTiming.status],
      updatedAt: json[AttributesTiming.updatedAt],
      createdAt: json[AttributesTiming.createdAt],
    );
  }
}
