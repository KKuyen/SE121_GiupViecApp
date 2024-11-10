import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/notification.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';

abstract class AllNotificationState extends Equatable {
  const AllNotificationState();

  @override
  List<Object> get props => [];
}

class AllNotificationInitial extends AllNotificationState {}

class AllNotificationLoading extends AllNotificationState {}

class AllNotificationSuccess extends AllNotificationState {
  final List<Notification> NotificationLs;

  const AllNotificationSuccess(this.NotificationLs);

  @override
  List<Object> get props => [NotificationLs];
}

class AllNotificationError extends AllNotificationState {
  final String message;

  const AllNotificationError(this.message);

  @override
  List<Object> get props => [message];
}
