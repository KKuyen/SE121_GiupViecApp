class Message {
  final int id;
  final String content;
  final int sourceId;
  final int targetId;
  final String createdAt;

  Message({
    required this.id,
    required this.content,
    required this.sourceId,
    required this.targetId,
    required this.createdAt,
  });
}
