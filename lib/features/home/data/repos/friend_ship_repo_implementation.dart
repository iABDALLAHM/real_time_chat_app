import 'package:real_time_chat_app/core/entities/friendship_entity.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/models/firestore_query.dart';
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
  Future<void> createFriendShip({
    required String user1Id,
    required String user2Id,
  }) async {
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
  }

  @override
  Future<void> removeFriendShip({
    required String user1Id,
    required String user2Id,
  }) async {
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
  }

  @override
  Future<void> blockUser({
    required String blockerId,
    required String blockedId,
  }) async {
    List<String> userIds = [blockerId, blockedId];
    userIds.sort();
    String friendShipId = "${userIds[0]}_${userIds[1]}";

    await dataBaseService.updateSingleData(
      path: BackendEndPoints.friendShips,
      data: {"isBlocked": true, "blockedBy": blockerId},
      documentId: friendShipId,
    );
  }

  // not now
  @override
  Future<void> unBlockUser({
    required String user1Id,
    required String user2Id,
  }) async {
    List<String> userIds = [user1Id, user2Id];
    userIds.sort();
    String friendShipId = "${userIds[0]}_${userIds[1]}";

    await dataBaseService.updateSingleData(
      path: BackendEndPoints.friendShips,
      data: {"isBlocked": false, "blockedBy": null},
      documentId: friendShipId,
    );
  }

  @override
  Stream<List<FriendshipEntity>> getFriendsStream({
    required String userId,
  }) async* {
    var data = dataBaseService.getAllDataQueryStream(
      path: BackendEndPoints.friendShips,
      query: FirestoreQuery(
        conditions: [QueryCondition(field: "userIds", isEqualTo: userId)],
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
      yield friendshipEntityList;
    }
  }

  @override
  Future<FriendshipEntity> getFriendShips({
    required String user1Id,
    required String user2Id,
  }) async {
    List<String> userIds = [user1Id, user2Id];
    userIds.sort();
    String friendShipId = "${userIds[0]}_${userIds[1]}";

    var doc = await dataBaseService.getSingleData(
      path: BackendEndPoints.friendShips,
      documentId: friendShipId,
    );
    FriendshipEntity friendshipEntity = FriendshipModel.fromMap(doc).toEntity();
    return friendshipEntity;
  }

  // not now
  @override
  Future<bool> isUserBlocked({
    required String userId,
    required String otherUserId,
  }) async {
    List<String> userIds = [userId, otherUserId];
    userIds.sort();
    String friendShipId = "${userIds[0]}_${userIds[1]}";

    var doc = await dataBaseService.getSingleData(
      path: BackendEndPoints.friendShips,
      documentId: friendShipId,
    );

    bool isUserBlocked = FriendshipModel.fromMap(doc).toEntity().isBlocked;
    return isUserBlocked;
  }

  // not now
  @override
  Future<bool> isUnFriended({
    required String userId,
    required String otherUserId,
  }) async {
    List<String> userIds = [userId, otherUserId];
    userIds.sort();
    String friendShipId = "${userIds[0]}_${userIds[1]}";
    var doc = await dataBaseService.getSingleData(
      path: BackendEndPoints.friendShips,
      documentId: friendShipId,
    );
    if (doc != null) {
      return true;
    }
    return false;
  }
}
