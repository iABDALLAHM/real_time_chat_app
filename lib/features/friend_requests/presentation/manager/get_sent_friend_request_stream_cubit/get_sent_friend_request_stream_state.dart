import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';

abstract class GetSentFriendRequestStreamStates {}

final class InitialGetSentFriendRequestStreamState
    extends GetSentFriendRequestStreamStates {}

final class LoadingGetSentFriendRequestStreamState
    extends GetSentFriendRequestStreamStates {}

final class SuccessGetSentFriendRequestStreamState
    extends GetSentFriendRequestStreamStates {
  final List<FriendRequestEntity> sentFriendRequestList;
  SuccessGetSentFriendRequestStreamState({required this.sentFriendRequestList});
}
