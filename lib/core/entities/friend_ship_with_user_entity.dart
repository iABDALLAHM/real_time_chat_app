import 'package:real_time_chat_app/core/entities/friendship_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';

class FriendShipWithUserEntity {
  final UserEntity userEntity;
  final FriendshipEntity friendshipEntity;

  FriendShipWithUserEntity({
    required this.userEntity,
    required this.friendshipEntity,
  });
}
