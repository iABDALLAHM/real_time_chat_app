import 'package:real_time_chat_app/core/entities/friend_request_with_user.dart';

abstract class GetSentFriendRequestStreamStates {}

final class InitialGetSentFriendRequestStreamState
    extends GetSentFriendRequestStreamStates {}

final class LoadingGetSentFriendRequestStreamState
    extends GetSentFriendRequestStreamStates {}

final class SuccessGetSentFriendRequestStreamState
    extends GetSentFriendRequestStreamStates {
  final List<FriendRequestWithUser> friendRequestWithUserList;
  SuccessGetSentFriendRequestStreamState({required this.friendRequestWithUserList});
}
