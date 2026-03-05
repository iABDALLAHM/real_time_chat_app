import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/notifications_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_notifications_stream_cubit/get_notifications_stream_state.dart';

class GetNotificationsStreamCubit extends Cubit<GetNotificationsStreamStates> {
  GetNotificationsStreamCubit({required this.notificationsRepo})
    : super(InitialGetNotificationsStreamState());
  final NotificationsRepo notificationsRepo;
  StreamSubscription? _streamSubscription;
  int notificationLenght = 0;
  void getNotifications({required String userId}) async {
    emit(LoadingGetNotificationsStreamState());
    _streamSubscription = notificationsRepo
        .getNotificationsStream(userId: userId)
        .listen((result) {
          result.fold(
            (failure) {
              emit(FailureGetNotificationsStreamState());
            },
            (success) {
              notificationLenght = success.length;
              if (success.isEmpty) {
                emit(EmptyNotificationsStreamState());
              } else {
                emit(
                  SuccessGetNotificationsStreamState(
                    notificationsList: success,
                  ),
                );
              }
            },
          );
        });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
