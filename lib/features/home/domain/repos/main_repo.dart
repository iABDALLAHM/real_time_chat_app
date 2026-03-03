import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';

abstract class MainRepo {
  Stream<List<UserEntity>> getAllUsersStream();
  Future<void> sendFriendRequest({
    required FriendRequestEntity friendRequestEntity,
  });
  Future<void> cancelFriendRequest({required String requestId});
  Future<void> respondToFriendRequest({
    required String requestId,
    required FriendRequestStatus status,
  });
  Stream<List<FriendRequestEntity>> getFriendRequestStream({
    required String userId,
  });
  Stream<List<FriendRequestEntity>> getSentFriendRequestStream({
    required String userId,
  });
}
