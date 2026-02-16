import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_friend_request_stream_cubit/get_friend_request_stream_state.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class GetFriendRequestStreamCubit extends Cubit<GetFriendRequestStreamStates> {
  GetFriendRequestStreamCubit({required this.mainRepo})
    : super(InitialGetFriendRequestStreamState());
  final MainRepo mainRepo;
  StreamSubscription? streamSubscription;
  int length = 0;
  void getFriendRequestStream({required String userId}) async {
    emit(LoadingGetFriendRequestStreamState());
    streamSubscription = mainRepo.getFriendRequestStream(userId: userId).listen(
      (result) {
        length = result.length;
        emit(SuccessGetFriendRequestStreamState(friendRequestList: result,));
      },
    );
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
