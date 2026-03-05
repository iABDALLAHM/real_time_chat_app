import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/notifications_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/notifications_cubit/notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationStates> {
  NotificationsCubit({required this.notificationsRepo})
    : super(InitialNotificationState());
  final NotificationsRepo notificationsRepo;

  void deleteNotification({required String notificationId}) async {
    emit(LoadingDeleteNotificationState());
    var result = await notificationsRepo.deleteNotification(
      notificationId: notificationId,
    );
    result.fold(
      (L) {
        emit(FailureDeleteNotificationState());
      },
      (R) {
        emit(SuccessDeleteNotificationState());
      },
    );
  }

  void markNotificationAsRead({required String notificationId}) async {
    emit(LoadingMarkNotificationAsReadState());
    var result = await notificationsRepo.markNotificationAsRead(
      notificationId: notificationId,
    );
    result.fold(
      (l) {
        emit(FailureMarkNotificationAsReadState());
      },
      (R) {
        emit(SuccessMarkNotificationAsReadState());
      },
    );
  }

  void markAllNotificationsAsRead({required String userId}) async {
    emit(LoadingMarkAllNotificationsAsReadState());
    var result = await notificationsRepo.markAllNotificationAsRead(
      userId: userId,
    );
    result.fold(
      (L) {
        emit(FailureMarkAllNotificationsAsReadState());
      },
      (R) {
        emit(SuccessMarkAllNotificationsAsReadState());
      },
    );
  }
}
