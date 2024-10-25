// lib/data/models/task_model.dart
import 'package:se121_giupviec_app/data/models/kuser_model.dart';
import 'package:se121_giupviec_app/data/models/location_model.dart';
import 'package:se121_giupviec_app/data/models/user_model.dart';
import 'package:se121_giupviec_app/domain/entities/kuser.dart';
import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required int id,
    required int userId,
    required int taskTypeId,
    required DateTime time,
    required int locationId,
    required String note,
    required int isReTaskChildren,
    required String taskStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
          id: id,
          userId: userId,
          taskTypeId: taskTypeId,
          time: time,
          locationId: locationId,
          note: note,
          isReTaskChildren: isReTaskChildren,
          taskStatus: taskStatus,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      userId: json['userId'],
      taskTypeId: json['taskTypeId'],
      time: DateTime.parse(json['time']),
      locationId: json['locationId'],
      note: json['note'],
      isReTaskChildren: json['isReTaskChildren'],
      taskStatus: json['taskStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'taskTypeId': taskTypeId,
      'time': time.toIso8601String(),
      'locationId': locationId,
      'note': note,
      'isReTaskChildren': isReTaskChildren,
      'taskStatus': taskStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
