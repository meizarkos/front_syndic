class AttributesTimingEstimate {
  static const uuid = 'uuid';
  static const estimateId =  'estimate_id';
  static const time = 'time';
  static const status = 'status';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class TimingEstimate{
  final String? uuid;
  final String? estimateId;
  final String? time;
  final String? status;
  final String? createdAt;
  final String? updatedAt;


  const TimingEstimate({
    this.uuid,
    this.estimateId,
    this.time,
    this.status,
    this.updatedAt,
    this.createdAt,
  });


  factory TimingEstimate.fromJson(Map<String, dynamic> json) {
    return TimingEstimate(
      uuid: json[AttributesTimingEstimate.uuid],
      estimateId: json[AttributesTimingEstimate.estimateId],
      time: json[AttributesTimingEstimate.time],
      status: json[AttributesTimingEstimate.status],
      updatedAt: json[AttributesTimingEstimate.updatedAt],
      createdAt: json[AttributesTimingEstimate.createdAt],
    );
  }
}
