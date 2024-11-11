// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/domain/entities/notification.dart';
import 'package:se121_giupviec_app/domain/entities/review.dart';
import 'package:se121_giupviec_app/domain/usecases/Notification/get_all_notification_usecase.dart';

import 'package:se121_giupviec_app/domain/usecases/get_all_reviews_usercase.dart';
import 'package:se121_giupviec_app/presentation/bloc/notification/notification_state.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/allReview_state.dart';

class allNotificationCubit extends Cubit<AllNotificationState> {
  final GetAllNotificationUseCase getAllNotificationsUsercase;

  allNotificationCubit({required this.getAllNotificationsUsercase})
      : super(AllNotificationInitial());

  Future<void> getAllNotifications(int userId) async {
    emit(AllNotificationLoading());
    try {
      print("chay vao Acubit");

      final List<Notification> taskerList =
          (await getAllNotificationsUsercase.execute(userId));

      emit(AllNotificationSuccess(taskerList));
    } catch (e) {
      emit(AllNotificationError(e.toString()));
    }
  }

  Future<void> deleteANotification(int notificationId) async {
    await getAllNotificationsUsercase.deleteANotification(notificationId);
  }

  Future<void> addANotificaiton(
      int userId, String header, String content, String image) async {
    await getAllNotificationsUsercase.addANotification(
        userId, header, content, image);
  }
}
