import '../../entities/messageReview.dart';
import '../../repository/message_repository.dart';

class GetMyMessageReviewUseCase {
  final MessageRepository repository;

  GetMyMessageReviewUseCase(this.repository);

  Future<List<MessageReview>> execute(int sourceId) async {
    return await repository.getMessagesReview(sourceId);
  }
}
