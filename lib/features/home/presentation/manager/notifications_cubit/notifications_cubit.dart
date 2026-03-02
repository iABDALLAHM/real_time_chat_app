import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/notifications_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/notifications_cubit/notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationStates> {
  NotificationsCubit({required this.notificationsRepo})
    : super(InitialNotificationState());
  final NotificationsRepo notificationsRepo;

  void deleteNotification({required String notificationId}) async {
    emit(LoadingDeleteNotificationState());
    await notificationsRepo.deleteNotification(notificationId: notificationId);
    emit(SuccessDeleteNotificationState());
  }

  void markNotificationAsRead({required String notificationId}) async {
    emit(LoadingMarkNotificationAsReadState());
    await notificationsRepo.markNotificationAsRead(notificationId: notificationId);
    emit(SuccessMarkNotificationAsReadState());
  }

  void markAllNotificationsAsRead({required String userId}) async {
    emit(LoadingMarkAllNotificationsAsReadState());
    await notificationsRepo.markAllNotificationAsRead(userId: userId);
    emit(SuccessMarkAllNotificationsAsReadState());
  }
}
