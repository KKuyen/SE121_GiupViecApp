import 'package:se121_giupviec_app/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    required int id,
    required int taskId,
    required int taskerId,
    required int userId,
    required String? userAvatar,
    required String userName,
    required int star,
    required String? content,
    required String? image1,
    required String? image2,
    required String? image3,
    required String? image4,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Object? task,
    required Object? taskType,
  }) : super(
          id: id,
          taskId: taskId,
          taskerId: taskerId,
          userId: userId,
          userAvatar: userAvatar,
          userName: userName,
          star: star,
          content: content,
          image1: image1,
          image2: image2,
          image3: image3,
          image4: image4,
          createdAt: createdAt,
          updatedAt: updatedAt,
          task: task,
          taskType: taskType,
        );

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
