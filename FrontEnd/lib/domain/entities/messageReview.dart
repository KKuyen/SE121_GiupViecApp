class MessageReview {
  final int id;
  final String lastMessage;
  final String lastMessageTime;
  final int sourceId;
  final int targetId;
  final Object target;

  MessageReview(
      {required this.id,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.sourceId,
      required this.targetId,
      required this.target});
}
