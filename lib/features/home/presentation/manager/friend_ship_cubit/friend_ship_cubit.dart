import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/features/home/domain/repos/friend_ship_repo.dart';
import 'package:real_time_chat_app/features/home/presentation/manager/friend_ship_cubit/friend_ship_states.dart';

class FriendShipCubit extends Cubit<FriendShipStates> {
  FriendShipCubit({required this.friendShipRepo}) : super(InitialFriendShipState());
  final FriendShipRepo friendShipRepo;

  void removeFriendShip({required String user1Id, required String user2Id}) {
    emit(LoadingRemoveFriendShipState());
    friendShipRepo.removeFriendShip(user1Id: user1Id, user2Id: user2Id);
    emit(SuccessRemoveFriendShipState());
  }

  void blockFriendShip({required String blockedId, required String blockerId}) {
    emit(LoadingBlockFriendShipState());
    friendShipRepo.blockUser(blockedId: blockedId, blockerId: blockerId);
    emit(SuccessBlockFriendShipState());
  }
}
