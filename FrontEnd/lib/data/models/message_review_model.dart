import '../../domain/entities/messageReview.dart';

class MessageReviewModel extends MessageReview {
  MessageReviewModel(
      {required super.id,
      required super.lastMessage,
      required super.lastMessageTime,
      required super.sourceId,
      required super.targetId,
      required super.target});

  factory MessageReviewModel.fromJson(Map<String, dynamic> json) {
    return MessageReviewModel(
      id: json['id'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
      sourceId: json['sourceId'],
      targetId: json['targetId'],
      target: json['target'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'sourceId': sourceId,
      'targetId': targetId,
      'target': target,
    };
  }
}
