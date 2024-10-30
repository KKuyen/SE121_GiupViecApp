class Review {
  final int id;
  final int taskId;
  final int taskerId;
  final int userId;
  final String? userAvatar;
  final String userName;
  final int star;
  final String? content;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Object? task;
  final Object? taskType;

  Review({
    required this.id,
    required this.taskId,
    required this.taskerId,
    required this.userId,
    this.userAvatar,
    required this.userName,
    required this.star,
    this.content,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    required this.createdAt,
    required this.updatedAt,
    this.task,
    this.taskType,
  });
}
