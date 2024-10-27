// lib/domain/entities/task.dart

// In taskType.dart

class TaskType {
  final int id;
  final String name;
  final String avatar;
  final String value;
  final String description;
  final String image;
  final double originalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskType({
    required this.id,
    required this.name,
    required this.avatar,
    required this.value,
    required this.description,
    required this.image,
    required this.originalPrice,
    required this.createdAt,
    required this.updatedAt,
  });
}
