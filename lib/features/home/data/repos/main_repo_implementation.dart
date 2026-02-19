import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/friendship_entity.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/models/chat_model.dart';
import 'package:real_time_chat_app/core/models/friend_request_model.dart';
import 'package:real_time_chat_app/core/models/friendship_model.dart';
import 'package:real_time_chat_app/core/models/message_model.dart';
import 'package:real_time_chat_app/core/models/notification_model.dart';
import 'package:real_time_chat_app/core/models/user_model.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

class MainRepoImplementation implements MainRepo {
  final DataBaseService dataBaseService;
  MainRepoImplementation({required this.dataBaseService});

  // done
  @override
  Stream<List<UserEntity>> getAllUsersStream() async* {
    await for (var userMaps in dataBaseService.getAllDataStream(
      isQuery: false,
      path: BackendEndPoints.getUsers,
    )) {
      final usersList = userMaps
          .map((user) => UserModel.fromMap(user).toEntity())
          .toList();
      yield usersList;
    }
  }

  // done
  @override
  Future<void> sendFriendRequest({
    required FriendRequestEntity friendRequest,
  }) async {
    await dataBaseService.addSinleData(
      path: BackendEndPoints.friendRequests,
      documentId: friendRequest.id,
      data: FriendRequestModel.fromEntity(
        friendRequestEntity: friendRequest,
      ).toMap(),
    );
    String notificationId =
        "friend_request_${friendRequest.senderId}_${friendRequest.receiverId}_${DateTime.now()}";

    NotificationEntity notificationEntity = NotificationEntity(
      id: notificationId,
      userId: friendRequest.receiverId,
      title: "New Friend Request",
      body: "You have recevied a new friend request",
      data: {"senderId": friendRequest.senderId, "requestId": friendRequest.id},
      type: NotificationType.friendRequest,
      createdAt: DateTime.now(),
    );
    await createNotification(notificationEntity: notificationEntity);
  }

  // done
  @override
  Future<void> cancelFriendRequest({required String requestId}) async {
    var requestDoc = await dataBaseService.getSingleData(
      path: BackendEndPoints.friendRequests,
      documentId: requestId,
    );

    FriendRequestModel friendRequestModel = FriendRequestModel.fromMap(
      requestDoc,
    );

    await deleteNotificationByTypeAndUser(
      userId: friendRequestModel.receiverId,
      type: NotificationType.friendRequest,
      relatedUserId: friendRequestModel.senderId,
    );

    await dataBaseService.deleteData(
      path: BackendEndPoints.friendRequests,
      documentId: requestId,
    );
  }

  // done
  @override
  Future<void> respondToFriendRequest({
    required String requestId,
    required FriendRequestStatus status,
  }) async {
    await dataBaseService.updateData(
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
      await createFriendShip(
        user1Id: friendRequestModel.senderId,
        user2Id: friendRequestModel.receiverId,
      );

      NotificationEntity notificationEntity = NotificationEntity(
        id: DateTime.now().toString(),
        userId: friendRequestModel.senderId,
        data: {"userId": friendRequestModel.receiverId},
        title: "Friend Request Accepted",
        body: "Your friend request has been accepted",
        type: NotificationType.friendRequestAccepted,
        createdAt: DateTime.now(),
      );

      await createNotification(notificationEntity: notificationEntity);

      await removeNotificationForCancelledRequest(
        receiverId: friendRequestModel.receiverId,
        senderId: friendRequestModel.senderId,
      );
    } else if (status == FriendRequestStatus.rejected) {
      NotificationEntity notificationEntity = NotificationEntity(
        id: DateTime.now().toString(),
        userId: friendRequestModel.senderId,
        data: {"userId": friendRequestModel.receiverId},
        title: "Friend Request declined",
        body: "Your friend request has been declined",
        type: NotificationType.friendRequestDecliend,
        createdAt: DateTime.now(),
      );

      await createNotification(notificationEntity: notificationEntity);

      await removeNotificationForCancelledRequest(
        receiverId: friendRequestModel.receiverId,
        senderId: friendRequestModel.senderId,
      );
    }
  }

  // done
  @override
  Stream<List<FriendRequestEntity>> getFriendRequestStream({
    required String userId,
  }) async* {
    var data = dataBaseService.getAllDataStream(
      path: BackendEndPoints.friendRequests,
      isQuery: true,
      query: {
        "receiverId": userId,
        "status": FriendRequestStatus.pending.name,
        "createdAt": true,
      },
    );

    await for (var userMaps in data) {
      final usersList = userMaps
          .map((user) => FriendRequestModel.fromMap(user).toEntity())
          .toList();
      yield usersList;
    }
  }

  // done
  @override
  Stream<List<FriendRequestEntity>> getSentFriendRequestStream({
    required String userId,
  }) async* {
    var data = dataBaseService.getAllDataStream(
      path: BackendEndPoints.friendRequests,
      isQuery: true,
      query: {"senderId": userId, "createdAt": true},
    );

    await for (var userMaps in data) {
      final usersList = userMaps
          .map((user) => FriendRequestModel.fromMap(user).toEntity())
          .toList();
      yield usersList;
    }
  }

  // done
  @override
  Future<FriendRequestEntity> getFriendRequest({
    required String senderId,
    required String receiverId,
  }) async {
    var data = await dataBaseService.getQueryData(
      path: BackendEndPoints.friendRequests,
      query: {
        "senderId": senderId,
        "receiverId": receiverId,
        "status": "pending",
      },
      isQuery: true,
    );

    List<FriendRequestEntity> friendRequestEntityList = [];
    for (var friendMap in data) {
      friendRequestEntityList.add(
        FriendRequestModel.fromMap(friendMap).toEntity(),
      );
    }
    return friendRequestEntityList.first;
  }

  // *********************************************************************************************************** (13/2)

  // friendship collections

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
      user1Id: userIds[0],
      user2Id: userIds[1],
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

    await dataBaseService.deleteData(
      path: BackendEndPoints.friendShips,
      documentId: friendShipId,
    );

    await createNotification(
      notificationEntity: NotificationEntity(
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

    await dataBaseService.updateData(
      path: BackendEndPoints.friendShips,
      data: {"isBlocked": true, "blockedBy": blockerId},
      documentId: friendShipId,
    );
  }

  @override
  Future<void> unBlockUser({
    required String user1Id,
    required String user2Id,
  }) async {
    List<String> userIds = [user1Id, user2Id];
    userIds.sort();
    String friendShipId = "${userIds[0]}_${userIds[1]}";

    await dataBaseService.updateData(
      path: BackendEndPoints.friendShips,
      data: {"isBlocked": false, "blockedBy": null},
      documentId: friendShipId,
    );
  }

  @override
  Stream<List<FriendshipEntity>> getFriendsStream({required String userId}) {
    // still not implemented
    throw UnimplementedError();
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

    FriendshipEntity friendshipEntity = FriendshipModel.fromMap(doc).toEntity();
    return friendshipEntity.isBlocked;
  }

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

  // ****************************************************************************************
  @override
  Future<String> createOrGetChat({
    required String user1Id,
    required String user2Id,
  }) async {
    List<String> participants = [user1Id, user2Id];
    participants.sort();
    String chatId = "${participants[0]}_${participants[1]}";
    var chatRefernce = await dataBaseService.getSingleData(
      path: BackendEndPoints.getChats,
      documentId: chatId,
    );
    if (chatRefernce == null) {
      ChatEntity newChat = ChatEntity(
        id: chatId,
        participants: participants,
        unreadCount: {user1Id: 0, user2Id: 0},
        deletedBy: {user1Id: false, user2Id: false},
        deletedAt: {user1Id: null, user2Id: null},
        lastSeenBy: {user1Id: DateTime.now(), user2Id: DateTime.now()},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await dataBaseService.addData(
        path: BackendEndPoints.addChats,
        data: ChatModel.fromEntity(chatEntity: newChat).toMap(),
      );
    } else {
      ChatEntity existingChat = ChatModel.fromMap(chatRefernce).toEntity();

      if (existingChat.isDeletedBy(userId: user1Id)) {
        await restoreChatForUser(chatId: chatId, userId: user1Id);
      }

      if (existingChat.isDeletedBy(userId: user2Id)) {
        await restoreChatForUser(chatId: chatId, userId: user2Id);
      }
    }
    return chatId;
  }

  @override
  Stream<List<ChatEntity>> getUserChatsStream({required String userId}) async* {
    // here is query
  }

  @override
  Future<void> updateChatLastMessage({
    required String chatId,
    required MessageEntity message,
  }) async {
    dataBaseService.updateData(
      path: BackendEndPoints.updateChats,
      data: {
        "lastMessage": message.content,
        "lastMessageTime": message,
        "lastMessageSenderId": message.senderId,
        "updatedAt": DateTime.now(),
      },
      documentId: chatId,
    );
  }

  @override
  Future<void> updateUserLastSeen({
    required String chatId,
    required String userId,
  }) async {
    await dataBaseService.updateData(
      path: BackendEndPoints.getChats,
      data: {"lastSeenBy.$userId": DateTime.now()},
      documentId: chatId,
    );
  }

  @override
  Future<void> deleteChatForUser({
    required String chatId,
    required String userId,
  }) async {
    await dataBaseService.updateData(
      path: BackendEndPoints.deleteChats,
      data: {"deletedBy.$userId": true, "deletedAt.$userId": DateTime.now()},
      documentId: chatId,
    );
  }

  @override
  Future<void> restoreChatForUser({
    required String chatId,
    required String userId,
  }) async {
    await dataBaseService.updateData(
      path: BackendEndPoints.chats,
      data: {"deletedBy.$userId": false},
      documentId: chatId,
    );
  }

  @override
  Future<void> updateunReadCount({
    required String chatId,
    required String userId,
    required int count,
  }) async {
    await dataBaseService.updateData(
      path: BackendEndPoints.chats,
      data: {"unreadCount.$userId": count},
      documentId: chatId,
    );
  }

  @override
  Future<void> restoreunReadCount({
    required String chatId,
    required String userId,
  }) async {
    await dataBaseService.updateData(
      path: BackendEndPoints.chats,
      data: {"unreadCount.$userId": 0},
      documentId: chatId,
    );
  }

  @override
  Future<void> sendMessage({required MessageEntity message}) async {
    await dataBaseService.addSinleData(
      path: BackendEndPoints.messages,
      data: MessageModel.formEntity(messageEntity: message).toMap(),
      documentId: message.id,
    );

    String chatId = await createOrGetChat(
      user1Id: message.senderId,
      user2Id: message.receiverId,
    );
    await updateChatLastMessage(chatId: chatId, message: message);
    await updateUserLastSeen(userId: message.senderId, chatId: chatId);

    // var chatDoc = await dataBaseService.getSingleData(
    //   path: BackendEndPoints.chats,
    //   documentId: chatId,
    // );
    // MessageEntity messageEntity = MessageModel.fromMap(chatDoc).toEntity();
    // int currentUnread = messageEntity.get
  }

  @override
  Future<void> createNotification({
    required NotificationEntity notificationEntity,
  }) async {
    await dataBaseService.addSinleData(
      path: BackendEndPoints.notification,
      data: NotificationModel.fromEntity(
        notificationEntity: notificationEntity,
      ).toMap(),
      documentId: notificationEntity.id,
    );
  }

  @override
  Future<void> removeNotificationForCancelledRequest({
    required String senderId,
    required String receiverId,
  }) async {
    await deleteNotificationByTypeAndUser(
      userId: receiverId,
      type: NotificationType.friendRequest,
      relatedUserId: senderId,
    );
  }

  @override
  Future<void> deleteNotificationByTypeAndUser({
    required String userId,
    required NotificationType type,
    required String relatedUserId,
  }) async {
    await dataBaseService.getQueryData(
      path: BackendEndPoints.notification,
      relatedId: relatedUserId,
      query: {"userId": userId, "type": type.name},
      isQuery: true,
    );
  }
}

// 58:00
