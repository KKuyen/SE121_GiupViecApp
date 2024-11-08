import '../../domain/entities/message.dart';

class MessageModel extends Message {
  MessageModel({
    required int id,
    required String content,
    required int sourceId,
    required int targetId,
    required String createdAt,
  }) : super(
          id: id,
          sourceId: sourceId,
          content: content,
          targetId: targetId,
          createdAt: createdAt,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      sourceId: json['sourceId'],
      content: json['content'],
      targetId: json['targetId'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sourceId': sourceId,
      'content': content,
      'targetId': targetId,
      'createdAt': createdAt,
    };
  }
}
