import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_sent_friend_request_stream_cubit/get_sent_friend_request_stream_state.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class GetSentFriendRequestStreamCubit
    extends Cubit<GetSentFriendRequestStreamStates> {
  GetSentFriendRequestStreamCubit({required this.mainRepo})
    : super(InitialGetSentFriendRequestStreamState());

  final MainRepo mainRepo;
  StreamSubscription? _streamSubscription;

  void getSentFriendRequestStream({required String userId}) {
    emit(LoadingGetSentFriendRequestStreamState());
    _streamSubscription = mainRepo
        .getSentFriendRequestStream(userId: userId)
        .listen((result) {
          emit(
            SuccessGetSentFriendRequestStreamState(
              sentFriendRequestList: result,
            ),
          );
        });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
