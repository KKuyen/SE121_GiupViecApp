import 'package:se121_giupviec_app/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel(
      {required int id,
      required int userId,
      required String header,
      required String? content,
      required String? image,
      required DateTime? createdAt,
      required DateTime? updatedAt})
      : super(
          id: id,
          userId: userId,
          header: header,
          image: image,
          content: content,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['userId'],
      header: json['header'],
      content: json['content'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'header': header,
      'content': content,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
