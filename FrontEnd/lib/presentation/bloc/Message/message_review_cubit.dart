// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/Message/get_message_review_usecase.dart';
import 'message_state.dart';

class MessageReviewCubit extends Cubit<MessageState> {
  final GetMyMessageReviewUseCase getMyMessageReviewUseCase;
  MessageReviewCubit({
    required this.getMyMessageReviewUseCase,
  }) : super(MessageInitial());

  Future<void> getMyMessageReview(int sourceId) async {
    emit(MessageLoading());
    try {
      print("chay vao cubit");
      final Messages = await getMyMessageReviewUseCase.execute(sourceId);
      emit(MessageReviewSuccess(Messages));
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}
