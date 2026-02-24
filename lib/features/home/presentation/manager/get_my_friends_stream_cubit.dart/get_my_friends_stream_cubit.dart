import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_ship_with_user_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_my_friends_stream_cubit.dart/get_my_friends_stream_states.dart';

class GetMyFriendsStreamCubit extends Cubit<GetMyFriendsStreamStates> {
  GetMyFriendsStreamCubit({required this.mainRepo, required this.authRepo})
    : super(InitialGetMyFriendsStreamState());
  final MainRepo mainRepo;
  final AuthRepo authRepo;
  StreamSubscription? _streamSubscription;
  void getMyFriends({required String userId}) {
    emit(LoadingGetMyFriendsStreamState());
    _streamSubscription = mainRepo.getFriendsStream(userId: userId).listen((
      result,
    ) async {
      if (result.isEmpty) {
        emit(EmptyFriendsStreamState());
      } else {
        List<FriendShipWithUserEntity> friendShipWithUserList = [];
        for (var friendShip in result) {
          String friendId = friendShip.userIds.firstWhere(
            (ids) => ids != userId,
          );
          UserEntity myFriendData = await authRepo.getUserData(uId: friendId);
          friendShipWithUserList.add(
            FriendShipWithUserEntity(
              userEntity: myFriendData,
              friendshipEntity: friendShip,
            ),
          );
        }
        emit(
          SuccessGetMyFriendsStreamState(
            friendShipWithUserList: friendShipWithUserList,
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
