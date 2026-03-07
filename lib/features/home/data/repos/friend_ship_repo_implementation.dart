import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/friendship_entity.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';
import 'package:real_time_chat_app/core/models/query_params.dart';
import 'package:real_time_chat_app/core/models/friendship_model.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/home/domain/repos/friend_ship_repo.dart';
import 'package:real_time_chat_app/features/home/domain/repos/notifications_repo.dart';

class FriendShipRepoImplementation implements FriendShipRepo {
  final DataBaseService dataBaseService;
  final NotificationsRepo notificationsRepo;
  FriendShipRepoImplementation({
    required this.dataBaseService,
    required this.notificationsRepo,
  });

  @override
  Future<Either<Failure, void>> createFriendShip({
    required String user1Id,
    required String user2Id,
  }) async {
    try {
      List<String> userIds = [user1Id, user2Id];
      userIds.sort();
      String friendShipId = "${userIds[0]}_${userIds[1]}";

      FriendshipModel friendshipModel = FriendshipModel(
        id: friendShipId,
        userIds: userIds,
        createdAt: DateTime.now(),
      );

      await dataBaseService.addSinleData(
        path: BackendEndPoints.friendShips,
        data: friendshipModel.toMap(),
        documentId: friendShipId,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in FriendShipRepoImplementation in create FriendShip method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> removeFriendShip({
    required String user1Id,
    required String user2Id,
  }) async {
    try {
      List<String> userIds = [user1Id, user2Id];
      userIds.sort();
      String friendShipId = "${userIds[0]}_${userIds[1]}";

      await dataBaseService.deleteSingleData(
        path: BackendEndPoints.friendShips,
        documentId: friendShipId,
      );

      await dataBaseService.deleteSingleData(
        path: BackendEndPoints.chats,
        documentId: friendShipId,
      );

      await notificationsRepo.createNotification(
        notificationEntity: NotificationEntity(
          isRead: false,
          id: DateTime.now().toString(),
          userId: user2Id,
          data: {"userId": user1Id},
          title: "Friend Removed",
          body: "Your are not longer friends",
          type: NotificationType.friendRemoved,
          createdAt: DateTime.now(),
        ),
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in FriendShipRepoImplementation in remove FriendShip method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> blockUser({
    required String blockerId,
    required String blockedId,
  }) async {
    try {
      List<String> userIds = [blockerId, blockedId];
      userIds.sort();
      String friendShipId = "${userIds[0]}_${userIds[1]}";

      await dataBaseService.updateSingleData(
        path: BackendEndPoints.friendShips,
        data: {"isBlocked": true, "blockedBy": blockerId},
        documentId: friendShipId,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in FriendShipRepoImplementation in block User method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> unBlockUser({
    required String user1Id,
    required String user2Id,
  }) async {
    try {
      List<String> userIds = [user1Id, user2Id];
      userIds.sort();
      String friendShipId = "${userIds[0]}_${userIds[1]}";

      await dataBaseService.updateSingleData(
        path: BackendEndPoints.friendShips,
        data: {"isBlocked": false, "blockedBy": null},
        documentId: friendShipId,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in FriendShipRepoImplementation in un Block User method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Stream<Either<Failure, List<FriendshipEntity>>> getFriendsStream({
    required String userId,
  }) async* {
    try {
      var data = dataBaseService.getAllDataQueryStream(
        path: BackendEndPoints.friendShips,
        query: QueryParams(
          conditions: [QueryCondition(field: "userIds", arrayContains: userId)],
          orders: [],
        ),
      );
      List<FriendshipEntity> friendshipEntityList = [];
      await for (var friendshipMaps in data) {
        friendshipEntityList = friendshipMaps
            .map(
              (friendshipMaps) =>
                  FriendshipModel.fromMap(friendshipMaps).toEntity(),
            )
            .where((f) => !f.isBlocked)
            .toList();
        yield Right(friendshipEntityList);
      }
    } on CustomException catch (e) {
      log(
        "this error happend in FriendShipRepoImplementation in get Friends Stream method ${e.toString()}",
      );
      yield Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, FriendshipEntity>> getFriendShips({
    required String user1Id,
    required String user2Id,
  }) async {
    try {
      List<String> userIds = [user1Id, user2Id];
      userIds.sort();
      String friendShipId = "${userIds[0]}_${userIds[1]}";

      var doc = await dataBaseService.getSingleData(
        path: BackendEndPoints.friendShips,
        documentId: friendShipId,
      );
      FriendshipEntity friendshipEntity = FriendshipModel.fromMap(
        doc,
      ).toEntity();
      return Right(friendshipEntity);
    } on CustomException catch (e) {
      log(
        "this error happend in FriendShipRepoImplementation in get FriendShips method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserBlocked({
    required String userId,
    required String otherUserId,
  }) async {
    try {
      List<String> userIds = [userId, otherUserId];
      userIds.sort();
      String friendShipId = "${userIds[0]}_${userIds[1]}";

      var doc = await dataBaseService.getSingleData(
        path: BackendEndPoints.friendShips,
        documentId: friendShipId,
      );

      bool isUserBlocked = FriendshipModel.fromMap(doc).toEntity().isBlocked;
      return Right(isUserBlocked);
    } on CustomException catch (e) {
      log(
        "this error happend in FriendShipRepoImplementation in is User Blocked method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, bool>> isUnFriended({
    required String userId,
    required String otherUserId,
  }) async {
    try {
      List<String> userIds = [userId, otherUserId];
      userIds.sort();
      String friendShipId = "${userIds[0]}_${userIds[1]}";
      var doc = await dataBaseService.getSingleData(
        path: BackendEndPoints.friendShips,
        documentId: friendShipId,
      );
      if (doc != null) {
        return Right(true);
      }
      return Right(false);
    } on CustomException catch (e) {
      log(
        "this error happend in FriendShipRepoImplementation in is Un Friended method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }
}
