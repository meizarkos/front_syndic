import 'package:front_syndic/models/work_request/work_request.dart';

class AttributesConversation{
  static const String uuid = 'uuid';
  static const String message = 'message';
  static const String isFirst = 'is_first';
  static const String side = 'side';
  static const String workRequestId = 'work_request_id';
  static const String workRequest = 'work_request';
  static const String artisanId = 'artisan_id';
  static const String unionId = 'union_id';
  static const String councilId = 'council_id';
  static const String userId = 'user_id';
  static const String state = 'state';
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
  String? unionId;
  String? councilId;
  String? userId;
  WorkRequest? workRequest;
  String? state;
  String? updatedAt;
  String? createdAt;

  Conversation({
    this.uuid,
    this.message,
    this.isFirst,
    this.side,
    this.workRequestId,
    this.workRequest,
    this.artisanId,
    this.unionId,
    this.councilId,
    this.userId,
    this.state,
    this.updatedAt,
    this.createdAt,
  });

  Conversation.fromJson(Map<String, dynamic> json) {
    uuid = json[AttributesConversation.uuid];
    message = json[AttributesConversation.message];
    isFirst = json[AttributesConversation.isFirst];
    side = json[AttributesConversation.side];
    workRequestId = json[AttributesConversation.workRequestId];
    workRequest = json[AttributesConversation.workRequest] != null ? WorkRequest.fromJson(json[AttributesConversation.workRequest]) : null;
    artisanId = json[AttributesConversation.artisanId];
    unionId = json[AttributesConversation.unionId];
    councilId = json[AttributesConversation.councilId];
    userId = json[AttributesConversation.userId];
    state = json[AttributesConversation.state] ?? '';
    updatedAt = json[AttributesConversation.updatedAt];
    createdAt = json[AttributesConversation.createdAt];
  }
}