// lib/domain/entities/task.dart

class Task {
  final int id;
  final int userId;
  final int taskTypeId;
  final DateTime time;
  final int locationId;
  final String note;
  final int isReTaskChildren;
  final String taskStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    required this.id,
    required this.userId,
    required this.taskTypeId,
    required this.time,
    required this.locationId,
    required this.note,
    required this.isReTaskChildren,
    required this.taskStatus,
    required this.createdAt,
    required this.updatedAt,
  });
}
