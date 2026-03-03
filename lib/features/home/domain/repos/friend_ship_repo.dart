import 'package:real_time_chat_app/core/entities/friendship_entity.dart';

abstract class FriendShipRepo {
  Future<void> createFriendShip({
    required String user1Id,
    required String user2Id,
  });

  Future<void> removeFriendShip({
    required String user1Id,
    required String user2Id,
  });

  Future<void> blockUser({
    required String blockerId,
    required String blockedId,
  });

  Future<void> unBlockUser({required String user1Id, required String user2Id});

  Stream<List<FriendshipEntity>> getFriendsStream({required String userId});

  Future<FriendshipEntity> getFriendShips({
    required String user1Id,
    required String user2Id,
  });

  Future<bool> isUserBlocked({
    required String userId,
    required String otherUserId,
  });

  Future<bool> isUnFriended({
    required String userId,
    required String otherUserId,
  });
}
