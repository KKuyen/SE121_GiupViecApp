class Notification {
  final int id;
  final int userId;
  final String header;
  final String? content;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Notification({
    required this.id,
    required this.userId,
    required this.header,
    this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
  });
}
