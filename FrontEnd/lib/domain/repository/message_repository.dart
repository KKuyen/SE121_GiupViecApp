import '../entities/message.dart';
import '../entities/messageReview.dart';

abstract class MessageRepository {
  Future<List<Message>> getMessages(int sourceId, int targetId);
  Future<List<MessageReview>> getMessagesReview(int sourceId);
}
