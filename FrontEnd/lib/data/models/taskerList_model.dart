// lib/data/models/task_model.dart
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';

import '../../domain/entities/task.dart';

class TaskerListModel extends TaskerList {
  TaskerListModel({
    required int id,
    required int taskId,
    required int taskerId,
    required int? reviewStar,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Object? tasker,
  }) : super(
          id: id,
          taskId: taskId,
          taskerId: taskerId,
          reviewStar: reviewStar,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
          tasker: tasker,
        );

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
