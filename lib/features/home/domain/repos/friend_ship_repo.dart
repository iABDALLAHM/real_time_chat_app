import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/friendship_entity.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';

abstract class FriendShipRepo {
  Future<Either<Failure, void>> createFriendShip({
    required String user1Id,
    required String user2Id,
  });

  Future<Either<Failure, void>> removeFriendShip({
    required String user1Id,
    required String user2Id,
  });

  Future<Either<Failure, void>> blockUser({
    required String blockerId,
    required String blockedId,
  });

  Future<Either<Failure, void>> unBlockUser({
    required String user1Id,
    required String user2Id,
  });

  Stream<Either<Failure, List<FriendshipEntity>>> getFriendsStream({
    required String userId,
  });

  Future<Either<Failure, FriendshipEntity>> getFriendShips({
    required String user1Id,
    required String user2Id,
  });

  Future<Either<Failure, bool>> isUserBlocked({
    required String userId,
    required String otherUserId,
  });

  Future<Either<Failure, bool>> isUnFriended({
    required String userId,
    required String otherUserId,
  });
}
