class Task {
  final int id;
  final int userId;
  final int taskTypeId;
  final DateTime time;
  final int locationId;
  final String? note; // Allow null
  final int? isReTaskChildren; // Allow null
  final String taskStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? price; // Allow null
  final Object? location; // Allow null
  final Object? user; // Allow null
  final Object? taskType; // Allow null
  final List<Object>? taskerLists; // Allow null
  final int? numberOfTasker; // Allow null
  final DateTime? approvedAt; // Allow null
  final DateTime? cancelAt;
  final DateTime? finishedAt;
  final String? cancelReason; // Allow null
  final bool? isPaid;

  Task({
    required this.id,
    required this.userId,
    required this.taskTypeId,
    required this.time,
    required this.locationId,
    this.note,
    this.isReTaskChildren,
    required this.taskStatus,
    required this.createdAt,
    required this.updatedAt,
    this.price,
    this.location,
    this.user,
    this.taskType,
    this.taskerLists,
    this.numberOfTasker,
    this.approvedAt,
    this.cancelAt,
    this.finishedAt,
    this.cancelReason,
    this.isPaid,
  });
}
