import '../../domain/entities/message.dart';
import '../../domain/repository/message_repository.dart';
import '../datasources/message_remote_datasource.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDatasource remoteDataSource;

  MessageRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Message>> getMessages(int sourceId, int targetId) async {
    return await remoteDataSource.getMessages(sourceId, targetId);
  }
}
