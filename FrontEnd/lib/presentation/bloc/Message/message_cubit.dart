// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Message/get_messages_usecase.dart';
import 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final GetMyMessageUseCase getMyMessageUseCase;
  MessageCubit({
    required this.getMyMessageUseCase,
  }) : super(MessageInitial());

  Future<void> getMyMessage(int sourceId, int targetId) async {
    emit(MessageLoading());
    try {
      print("chay vao cubit");
      final Messages = await getMyMessageUseCase.execute(sourceId, targetId);
      emit(MessageSuccess(Messages));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}
