import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/notification_cubit/notification_states.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit({required this.mainRepo})
    : super(InitialNotificationState());
  final MainRepo mainRepo;

  void deleteNotification({required String notificationId}) async {
    emit(LoadingDeleteNotificationState());
    await mainRepo.deleteNotification(notificationId: notificationId);
    emit(SuccessDeleteNotificationState());
  }

  void markNotificationAsRead({required String notificationId}) async {
    emit(LoadingMarkNotificationAsReadState());
    await mainRepo.markNotificationAsRead(notificationId: notificationId);
    emit(SuccessMarkNotificationAsReadState());
  }
}
