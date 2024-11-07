import 'package:se121_giupviec_app/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required super.id,
    required super.taskId,
    required super.taskerId,
    required super.userId,
    required super.userAvatar,
    required super.userName,
    required super.star,
    required super.content,
    required super.image1,
    required super.image2,
    required super.image3,
    required super.image4,
    required super.createdAt,
    required super.updatedAt,
    required super.task,
    required super.taskType,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      taskId: json['taskId'],
      taskerId: json['taskerId'],
      userId: json['userId'],
      userAvatar: json['userAvatar'],
      userName: json['userName'],
      star: json['star'],
      content: json['content'],
      image1: json['image1'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      task: json['task'],
      taskType: json['taskType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'taskerId': taskerId,
      'userId': userId,
      'userAvatar': userAvatar,
      'userName': userName,
      'star': star,
      'content': content,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'task': task,
      'taskType': taskType,
    };
  }
}
