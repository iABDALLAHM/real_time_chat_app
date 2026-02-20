import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_notifications_stream_cubit/get_notifications_stream_state.dart';

class GetNotificationsStreamCubit extends Cubit<GetNotificationsStreamStates> {
  GetNotificationsStreamCubit({required this.mainRepo})
    : super(InitialGetNotificationsStreamState());
  final MainRepo mainRepo;
  StreamSubscription? _streamSubscription;
  int notificationLenght = 0;
  void getNotifications({required String userId}) async {
    emit(LoadingGetNotificationsStreamState());
    _streamSubscription = mainRepo
        .getNotificationsStream(userId: userId)
        .listen((result) {
          notificationLenght = result.length;
          emit(SuccessGetNotificationsStreamState(notificationsList: result));
        });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
