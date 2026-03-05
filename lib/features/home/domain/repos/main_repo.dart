import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';

abstract class MainRepo {
  Stream<Either<Failure, List<UserEntity>>> getAllUsersStream();
  Future<Either<Failure, void>> sendFriendRequest({
    required FriendRequestEntity friendRequestEntity,
  });
  Future<Either<Failure, void>> cancelFriendRequest({
    required String requestId,
  });
  Future<Either<Failure, void>> respondToFriendRequest({
    required String requestId,
    required FriendRequestStatus status,
  });
  Stream<Either<Failure, List<FriendRequestEntity>>> getFriendRequestStream({
    required String userId,
  });
  Stream<Either<Failure, List<FriendRequestEntity>>>
  getSentFriendRequestStream({required String userId});
}
