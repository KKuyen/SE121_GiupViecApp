class TaskerList {
  final int id;
  final int taskId;
  final int taskerId;
  final int? reviewStar;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Object? tasker;

  TaskerList({
    required this.id,
    required this.taskId,
    required this.taskerId,
    this.reviewStar,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.tasker,
  });
}
