import '../../domain/entities/message.dart';
import '../../domain/entities/messageReview.dart';
import '../../domain/repository/message_repository.dart';
import '../datasources/message_remote_datasource.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDatasource remoteDataSource;

  MessageRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Message>> getMessages(int sourceId, int targetId) async {
    return await remoteDataSource.getMessages(sourceId, targetId);
  }

  @override
  Future<List<MessageReview>> getMessagesReview(int sourceId) async {
    return await remoteDataSource.getMessagesReview(sourceId);
  }
}
