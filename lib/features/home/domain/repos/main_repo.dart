import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';

abstract class MainRepo {
  Stream<List<UserEntity>> getAllUsersStream();
  Future<void> sendFriendRequest({required FriendRequestEntity request});
}
