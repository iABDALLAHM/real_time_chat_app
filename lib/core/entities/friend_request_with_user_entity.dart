import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';

class FriendRequestWithUserEntity {
  final FriendRequestEntity friendRequestEntity;
  final UserEntity userEntity;

  FriendRequestWithUserEntity({
    required this.friendRequestEntity,
    required this.userEntity,
  });
}
