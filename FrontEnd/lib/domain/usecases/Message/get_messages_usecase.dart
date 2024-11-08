import '../../entities/message.dart';
import '../../repository/message_repository.dart';

class GetMyMessageUseCase {
  final MessageRepository repository;

  GetMyMessageUseCase(this.repository);

  Future<List<Message>> execute(int sourceId, int targetId) async {
    return await repository.getMessages(sourceId, targetId);
  }
}
