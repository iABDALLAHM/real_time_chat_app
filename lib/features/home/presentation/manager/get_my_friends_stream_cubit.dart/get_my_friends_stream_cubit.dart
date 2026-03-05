import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/core/entities/friend_ship_with_user_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';
import 'package:real_time_chat_app/features/home/domain/repos/friend_ship_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/get_my_friends_stream_cubit.dart/get_my_friends_stream_states.dart';

class GetMyFriendsStreamCubit extends Cubit<GetMyFriendsStreamStates> {
  GetMyFriendsStreamCubit({
    required this.friendShipRepo,
    required this.authRepo,
  }) : super(InitialGetMyFriendsStreamState());
  final FriendShipRepo friendShipRepo;
  final AuthRepo authRepo;
  StreamSubscription? _streamSubscription;
  void getMyFriends({required String userId}) {
    emit(LoadingGetMyFriendsStreamState());
    _streamSubscription = friendShipRepo
        .getFriendsStream(userId: userId)
        .listen((result) {
          result.fold(
            (failure) {
              emit(FailureGetMyFriendsStreamState());
            },
            (success) async {
              if (success.isEmpty) {
                emit(EmptyFriendsStreamState());
              } else {
                List<FriendShipWithUserEntity> friendShipWithUserList = [];
                for (var friendShip in success) {
                  String friendId = friendShip.userIds.firstWhere(
                    (ids) => ids != userId,
                  );
                  UserEntity myFriendData = await authRepo.getUserData(
                    uId: friendId,
                  );
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
