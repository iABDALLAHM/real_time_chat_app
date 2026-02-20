import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_request_with_user_entity.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/friend_requests/presentation/manager/get_friend_request_stream_cubit/get_friend_request_stream_state.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class GetFriendRequestStreamCubit extends Cubit<GetFriendRequestStreamStates> {
  GetFriendRequestStreamCubit({required this.mainRepo, required this.authRepo})
    : super(InitialGetFriendRequestStreamState());
  final MainRepo mainRepo;
  final AuthRepo authRepo;
  StreamSubscription? streamSubscription;
  int length = 0;
  void getFriendRequestStream({required String userId}) async {
    emit(LoadingGetFriendRequestStreamState());
    streamSubscription = mainRepo.getFriendRequestStream(userId: userId).listen(
      (result) async {
        length = result.length;
        List<FriendRequestWithUserEntity> friendRequestWithUserList = [];

        for (var request in result) {
          var user = await authRepo.getUserData(uId: request.senderId);

          friendRequestWithUserList.add(
            FriendRequestWithUserEntity(
              friendRequestEntity: request,
              userEntity: user,
            ),
          );

          emit(
            SuccessGetFriendRequestStreamState(
              friendRequestWithUserList: friendRequestWithUserList,
            ),
          );
        }
      },
    );
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
