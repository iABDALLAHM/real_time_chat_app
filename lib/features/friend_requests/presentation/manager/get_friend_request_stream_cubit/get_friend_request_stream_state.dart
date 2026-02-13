import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';

abstract class GetFriendRequestStreamStates {}

final class InitialGetFriendRequestStreamState
    extends GetFriendRequestStreamStates {}

final class LoadingGetFriendRequestStreamState
    extends GetFriendRequestStreamStates {}

final class SuccessGetFriendRequestStreamState
    extends GetFriendRequestStreamStates {
      final List<FriendRequestEntity> friendRequestList;

  SuccessGetFriendRequestStreamState({required this.friendRequestList});
    }

final class FailureGetFriendRequestStreamState
    extends GetFriendRequestStreamStates {}
