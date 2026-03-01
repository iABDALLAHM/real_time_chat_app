import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_with_user_entity.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_sent_friend_request_stream_cubit/get_sent_friend_request_stream_state.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class GetSentFriendRequestStreamCubit
    extends Cubit<GetSentFriendRequestStreamStates> {
  GetSentFriendRequestStreamCubit({
    required this.mainRepo,
    required this.authRepo,
  }) : super(InitialGetSentFriendRequestStreamState());

  final MainRepo mainRepo;
  final AuthRepo authRepo;
  StreamSubscription? _streamSubscription;
  int length = 0;
  void getSentFriendRequestStream({required String userId}) {
    emit(LoadingGetSentFriendRequestStreamState());
    _streamSubscription = mainRepo
        .getSentFriendRequestStream(userId: userId)
        .listen((result) async {
          length = result.length;
          List<FriendRequestWithUserEntity> friendRequestWithUserList = [];

          for (var request in result) {
            // there are aproblem here
            var user = await authRepo.getUserData(uId: request.senderId);
            friendRequestWithUserList.add(
              FriendRequestWithUserEntity(
                friendRequestEntity: request,
                userEntity: user,
              ),
            );
            emit(
              SuccessGetSentFriendRequestStreamState(
                friendRequestWithUserList: friendRequestWithUserList,
              ),
            );
          }
        });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
