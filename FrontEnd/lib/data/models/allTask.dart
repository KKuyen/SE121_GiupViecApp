// lib/data/models/task_response.dart
import 'task_model.dart';

class TaskResponseModel {
  final int errCode;
  final String message;
  final List<TaskModel> taskList;

  TaskResponseModel({
    required this.errCode,
    required this.message,
    required this.taskList,
  });

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskResponseModel(
      errCode: json['errCode'],
      message: json['message'],
      taskList: (json['taskList'] as List)
          .map((task) => TaskModel.fromJson(task))
          .toList(),
    );
  }
}
