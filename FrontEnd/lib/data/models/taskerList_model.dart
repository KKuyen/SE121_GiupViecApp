// lib/data/models/task_model.dart
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';

class TaskerListModel extends TaskerList {
  TaskerListModel({
    required super.id,
    required super.taskId,
    required super.taskerId,
    required super.reviewStar,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.tasker,
  });

  factory TaskerListModel.fromJson(Map<String, dynamic> json) {
    return TaskerListModel(
      id: json['id'],
      taskId: json['taskId'],
      taskerId: json['taskerId'],
      reviewStar: json['reviewStar'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      tasker: json['tasker'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'taskerId': taskerId,
      'reviewStar': reviewStar,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'tasker': tasker,
    };
  }
}
