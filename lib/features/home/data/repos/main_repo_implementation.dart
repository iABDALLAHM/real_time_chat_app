import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';
import 'package:real_time_chat_app/core/models/query_params.dart';
import 'package:real_time_chat_app/core/models/friend_request_model.dart';
import 'package:real_time_chat_app/core/models/user_model.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/home/domain/repos/friend_ship_repo.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';
import 'package:real_time_chat_app/features/home/domain/repos/notifications_repo.dart';

class MainRepoImplementation implements MainRepo {
  final DataBaseService dataBaseService;
  final NotificationsRepo notificationsRepo;
  final FriendShipRepo friendShipRepo;
  MainRepoImplementation({
    required this.dataBaseService,
    required this.notificationsRepo,
    required this.friendShipRepo,
  });

  @override
  Stream<Either<Failure, List<UserEntity>>> getAllUsersStream() async* {
    try {
      await for (var userMaps in dataBaseService.getAllDataStream(
        path: BackendEndPoints.getUsers,
      )) {
        final usersList = userMaps
            .map((user) => UserModel.fromMap(user).toEntity())
            .toList();
        yield Right(usersList);
      }
    } on CustomException catch (e) {
      log(
        "this error happend in MainRepoImplementation in getAllUsersStream method ${e.toString()}",
      );
      yield left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> sendFriendRequest({
    required FriendRequestEntity friendRequestEntity,
  }) async {
    try {
      await dataBaseService.addSinleData(
        path: BackendEndPoints.friendRequests,
        documentId: friendRequestEntity.id,
        data: FriendRequestModel.fromEntity(
          friendRequestEntity: friendRequestEntity,
        ).toMap(),
      );

      NotificationEntity notificationEntity = NotificationEntity(
        isRead: false,
        id: friendRequestEntity.id,
        userId: friendRequestEntity.receiverId,
        title: "New Friend Request",
        body: "You have recevied a new friend request",
        data: {
          "senderId": friendRequestEntity.senderId,
          "requestId": friendRequestEntity.receiverId,
        },
        type: NotificationType.friendRequest,
        createdAt: DateTime.now(),
      );

      await notificationsRepo.createNotification(
        notificationEntity: notificationEntity,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in MainRepoImplementation in sendFriendRequest method ${e.toString()}",
      );
      return left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> cancelFriendRequest({
    required String requestId,
  }) async {
    try {
      var requestDoc = await dataBaseService.getSingleData(
        path: BackendEndPoints.friendRequests,
        documentId: requestId,
      );

      FriendRequestModel friendRequestModel = FriendRequestModel.fromMap(
        requestDoc,
      );

      await notificationsRepo.deleteNotificationByTypeAndUser(
        userId: friendRequestModel.receiverId,
        type: NotificationType.friendRequest,
      );

      await dataBaseService.deleteSingleData(
        path: BackendEndPoints.friendRequests,
        documentId: requestId,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in MainRepoImplementation in cancelFriendRequest method ${e.toString()}",
      );
      return left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> respondToFriendRequest({
    required String requestId,
    required FriendRequestStatus status,
  }) async {
    try {
      await dataBaseService.updateSingleData(
        documentId: requestId,
        path: BackendEndPoints.friendRequests,
        data: {"status": status.name, "responsedAt": DateTime.now()},
      );

      var requestDoc = await dataBaseService.getSingleData(
        path: BackendEndPoints.friendRequests,
        documentId: requestId,
      );

      FriendRequestModel friendRequestModel = FriendRequestModel.fromMap(
        requestDoc,
      );

      if (status == FriendRequestStatus.accepted) {
        await friendShipRepo.createFriendShip(
          user1Id: friendRequestModel.senderId,
          user2Id: friendRequestModel.receiverId,
        );

        NotificationEntity notificationEntity = NotificationEntity(
          isRead: false,
          id: DateTime.now().toString(),
          userId: friendRequestModel.senderId,
          data: {"userId": friendRequestModel.receiverId},
          title: "Friend Request Accepted",
          body: "Your friend request has been accepted",
          type: NotificationType.friendRequestAccepted,
          createdAt: DateTime.now(),
        );

        await notificationsRepo.createNotification(
          notificationEntity: notificationEntity,
        );

        await notificationsRepo.removeNotificationForCancelledRequest(
          receiverId: friendRequestModel.receiverId,
          senderId: friendRequestModel.senderId,
        );
      } else if (status == FriendRequestStatus.rejected) {
        NotificationEntity notificationEntity = NotificationEntity(
          isRead: false,
          id: DateTime.now().toString(),
          userId: friendRequestModel.senderId,
          data: {"userId": friendRequestModel.receiverId},
          title: "Friend Request declined",
          body: "Your friend request has been declined",
          type: NotificationType.friendRequestDecliend,
          createdAt: DateTime.now(),
        );

        await notificationsRepo.createNotification(
          notificationEntity: notificationEntity,
        );

        await notificationsRepo.removeNotificationForCancelledRequest(
          receiverId: friendRequestModel.receiverId,
          senderId: friendRequestModel.senderId,
        );
      }
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in MainRepoImplementation in respond To Friend Request method ${e.toString()}",
      );
      return left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Stream<Either<Failure, List<FriendRequestEntity>>> getFriendRequestStream({
    required String userId,
  }) async* {
    try {
      var data = dataBaseService.getAllDataQueryStream(
        path: BackendEndPoints.friendRequests,
        query: QueryParams(
          conditions: [
            QueryCondition(
              field: "status",
              isEqualTo: FriendRequestStatus.pending.name,
            ),
            QueryCondition(field: "receiverId", isEqualTo: userId),
          ],
          orders: [QueryOrder(field: "createdAt", descending: true)],
        ),
      );

      await for (var userMaps in data) {
        final usersList = userMaps
            .map((user) => FriendRequestModel.fromMap(user).toEntity())
            .toList();
        yield Right(usersList);
      }
    } on CustomException catch (e) {
      log(
        "this error happend in MainRepoImplementation in get Friend Request Stream method ${e.toString()}",
      );
      yield left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Stream<Either<Failure, List<FriendRequestEntity>>>
  getSentFriendRequestStream({required String userId}) async* {
    try {
      var data = dataBaseService.getAllDataQueryStream(
        path: BackendEndPoints.friendRequests,
        query: QueryParams(
          conditions: [QueryCondition(field: "senderId", isEqualTo: userId)],
          orders: [QueryOrder(field: "createdAt", descending: true)],
        ),
      );

      await for (var userMaps in data) {
        final usersList = userMaps
            .map((user) => FriendRequestModel.fromMap(user).toEntity())
            .toList();
        yield Right(usersList);
      }
    } on CustomException catch (e) {
      log(
        "this error happend in MainRepoImplementation in get Sent Friend Request Stream method ${e.toString()}",
      );
      yield left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }
}
