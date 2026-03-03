import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/models/firestore_query.dart';
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
  Stream<List<UserEntity>> getAllUsersStream() async* {
    await for (var userMaps in dataBaseService.getAllDataStream(
      path: BackendEndPoints.getUsers,
    )) {
      final usersList = userMaps
          .map((user) => UserModel.fromMap(user).toEntity())
          .toList();
      yield usersList;
    }
  }

  @override
  Future<void> sendFriendRequest({
    required FriendRequestEntity friendRequestEntity,
  }) async {
    await dataBaseService.addSinleData(
      path: BackendEndPoints.friendRequests,
      documentId: friendRequestEntity.id,
      data: FriendRequestModel.fromEntity(
        friendRequestEntity: friendRequestEntity,
      ).toMap(),
    );

    String notificationId =
        "friend_request_${friendRequestEntity.senderId}_${friendRequestEntity.receiverId}_${DateTime.now()}";

    NotificationEntity notificationEntity = NotificationEntity(
      isRead: false,
      id: notificationId,
      userId: friendRequestEntity.receiverId,
      title: "New Friend Request",
      body: "You have recevied a new friend request",
      data: {"senderId": friendRequestEntity.senderId, "requestId": friendRequestEntity.id},
      type: NotificationType.friendRequest,
      createdAt: DateTime.now(),
    );

    await notificationsRepo.createNotification(
      notificationEntity: notificationEntity,
    );

  }

  @override
  Future<void> cancelFriendRequest({required String requestId}) async {
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
  }

  @override
  Future<void> respondToFriendRequest({
    required String requestId,
    required FriendRequestStatus status,
  }) async {
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
  }

  @override
  Stream<List<FriendRequestEntity>> getFriendRequestStream({
    required String userId,
  }) async* {
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
      yield usersList;
    }
  }

  @override
  Stream<List<FriendRequestEntity>> getSentFriendRequestStream({
    required String userId,
  }) async* {
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
      yield usersList;
    }
  }

  // @override
  // Future<FriendRequestEntity> getFriendRequest({
  //   required String senderId,
  //   required String receiverId,
  // }) async {
  //   var data = await dataBaseService.getQueryData(
  //     path: BackendEndPoints.friendRequests,
  //     query: QueryParams(
  //       conditions: [
  //         QueryCondition(field: "senderId", isEqualTo: senderId),
  //         QueryCondition(field: "receiverId", isEqualTo: receiverId),
  //         QueryCondition(field: "status", isEqualTo: "pending"),
  //       ],
  //       orders: [],
  //     ),
  //   );

  //   List<FriendRequestEntity> friendRequestEntityList = [];
  //   for (var friendMap in data) {
  //     friendRequestEntityList.add(
  //       FriendRequestModel.fromMap(friendMap).toEntity(),
  //     );
  //   }
  //   return friendRequestEntityList.first;
  // }
}
