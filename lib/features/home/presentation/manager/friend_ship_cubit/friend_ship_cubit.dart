import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/friend_ship_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/friend_ship_cubit/friend_ship_states.dart';

class FriendShipCubit extends Cubit<FriendShipStates> {
  FriendShipCubit({required this.friendShipRepo})
    : super(InitialFriendShipState());
  final FriendShipRepo friendShipRepo;

  void removeFriendShip({
    required String user1Id,
    required String user2Id,
  }) async {
    emit(LoadingRemoveFriendShipState());
    var result = await friendShipRepo.removeFriendShip(
      user1Id: user1Id,
      user2Id: user2Id,
    );
    result.fold(
      (L) {
        emit(FailureRemoveFriendShipState());
      },
      (R) {
        emit(SuccessRemoveFriendShipState());
      },
    );
  }

  void blockFriendShip({
    required String blockedId,
    required String blockerId,
  }) async {
    emit(LoadingBlockFriendShipState());
    var result = await friendShipRepo.blockUser(
      blockedId: blockedId,
      blockerId: blockerId,
    );
    result.fold(
      (L) {
        emit(FailureBlockFriendShipState());
      },
      (R) {
        emit(SuccessBlockFriendShipState());
      },
    );
  }
}
