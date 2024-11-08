class AttributesConversation{
  static const String uuid = 'uuid';
  static const String message = 'message';
  static const String isFirst = 'is_first';
  static const String side = 'side';
  static const String workRequestId = 'work_request_id';
  static const String artisanId = 'artisan_id';
  static const String updatedAt = 'upadated_at';
  static const String createdAt = 'created_at';
}

class Conversation {
  String? uuid;
  String? message;
  bool? isFirst;
  String? side;
  String? workRequestId;
  String? artisanId;
  String? updatedAt;
  String? createdAt;

  Conversation({
    this.uuid,
    this.message,
    this.isFirst,
    this.side,
    this.workRequestId,
    this.artisanId,
    this.updatedAt,
    this.createdAt,
  });

  Conversation.fromJson(Map<String, dynamic> json) {
    uuid = json[AttributesConversation.uuid];
    message = json[AttributesConversation.message];
    isFirst = json[AttributesConversation.isFirst];
    side = json[AttributesConversation.side];
    workRequestId = json[AttributesConversation.workRequestId];
    artisanId = json[AttributesConversation.artisanId];
    updatedAt = json[AttributesConversation.updatedAt];
    createdAt = json[AttributesConversation.createdAt];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[AttributesConversation.uuid] = uuid;
    data[AttributesConversation.message] = message;
    data[AttributesConversation.isFirst] = isFirst;
    data[AttributesConversation.workRequestId] = workRequestId;
    data[AttributesConversation.artisanId] = artisanId;
    data[AttributesConversation.updatedAt] = updatedAt.toString();
    data[AttributesConversation.createdAt] = createdAt.toString();
    return data;
  }
}