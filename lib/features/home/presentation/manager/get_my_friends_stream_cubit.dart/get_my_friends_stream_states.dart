import 'package:real_time_chat_app/core/entities/friend_ship_with_user_entity.dart';

abstract class GetMyFriendsStreamStates {}

final class InitialGetMyFriendsStreamState extends GetMyFriendsStreamStates {}

final class SuccessGetMyFriendsStreamState extends GetMyFriendsStreamStates {
  final List<FriendShipWithUserEntity> friendShipWithUserList;

  SuccessGetMyFriendsStreamState({required this.friendShipWithUserList});
}

final class LoadingGetMyFriendsStreamState extends GetMyFriendsStreamStates {}

final class FailureGetMyFriendsStreamState extends GetMyFriendsStreamStates {}

final class EmptyFriendsStreamState extends GetMyFriendsStreamStates {}
