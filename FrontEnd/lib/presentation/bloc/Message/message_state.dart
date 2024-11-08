// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';

import '../../../domain/entities/message.dart';
import '../../../domain/entities/messageReview.dart';
import '../../../domain/entities/response.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];

  Object get prop => Message;
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class DefaultMessageLoading extends MessageState {}

class MessageSuccess extends MessageState {
  final List<Message> messages;

  const MessageSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

class MessageReviewSuccess extends MessageState {
  final List<MessageReview> messageReviews;

  const MessageReviewSuccess(this.messageReviews);

  @override
  List<Object> get props => [messageReviews];
}

class MessageResponseSuccess extends MessageState {
  final Response response;

  const MessageResponseSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class DefaultMessageSuccess extends MessageState {
  final Message location;

  const DefaultMessageSuccess(this.location);

  @override
  Object get prop => location;
}

class MessageError extends MessageState {
  final String message;

  const MessageError(this.message);

  @override
  List<Object> get props => [message];
}

class DefaultMessageError extends MessageState {
  final String message;

  const DefaultMessageError(this.message);

  @override
  List<Object> get props => [message];
}
