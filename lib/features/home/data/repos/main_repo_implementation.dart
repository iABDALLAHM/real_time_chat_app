import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/models/chat_model.dart';
import 'package:real_time_chat_app/core/models/friend_request_model.dart';
import 'package:real_time_chat_app/core/models/message_model.dart';
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
  MainRepoImplementation({required this.dataBaseService, required this.notificationsRepo, required this.friendShipRepo});

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
      isRead: false,
      id: notificationId,
      userId: friendRequest.receiverId,
      title: "New Friend Request",
      body: "You have recevied a new friend request",
      data: {"senderId": friendRequest.senderId, "requestId": friendRequest.id},
      type: NotificationType.friendRequest,
      createdAt: DateTime.now(),
    );
    await notificationsRepo.createNotification(notificationEntity: notificationEntity);
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
      relatedUserId: friendRequestModel.senderId,
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

      await notificationsRepo.createNotification(notificationEntity: notificationEntity);

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

      await notificationsRepo.createNotification(notificationEntity: notificationEntity);

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
      path: BackendEndPoints.chats,
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

      await dataBaseService.addSinleData(
        documentId: chatId,
        path: BackendEndPoints.chats,
        data: ChatModel.fromEntity(chatEntity: newChat).toMap(),
      );
    }

    // not now
    //  else {
    //   ChatEntity existingChat = ChatModel.fromMap(chatRefernce).toEntity();

    //   if (existingChat.isDeletedBy(userId: user1Id)) {
    //     await restoreChatForUser(chatId: chatId, userId: user1Id);
    //   }

    //   if (existingChat.isDeletedBy(userId: user2Id)) {
    //     await restoreChatForUser(chatId: chatId, userId: user2Id);
    //   }
    // }

    return chatId;
  }

  @override
  Stream<List<ChatEntity>> getUserChatsStream({required String userId}) async* {
    var data = dataBaseService.getAllDataStream(
      path: BackendEndPoints.chats,
      isQuery: true,
      query: {"participants": userId, "updatedAt": true},
    );
    await for (var chatModel in data) {
      var chatList = chatModel
          .map((chat) => ChatModel.fromMap(chat).toEntity())
          .where((chat) => !chat.isDeletedBy(userId: userId))
          .toList();
      yield chatList;
    }
  }

  @override
  Future<void> updateChatLastMessage({
    required String chatId,
    required MessageEntity message,
  }) async {
    dataBaseService.updateSingleData(
      path: BackendEndPoints.chats,
      data: {
        "lastMessage": message.content,
        "lastMessageTime": message.timeStamp,
        "lastMessageSenderId": message.messageSenderId,
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
    await dataBaseService.updateSingleData(
      path: BackendEndPoints.chats,
      data: {"lastSeenBy.$userId": DateTime.now()},
      documentId: chatId,
    );
  }

  @override
  Future<void> deleteChatForUser({
    required String chatId,
    required String userId,
  }) async {
    await dataBaseService.updateSingleData(
      path: BackendEndPoints.chats,
      data: {"deletedBy.$userId": true, "deletedAt.$userId": DateTime.now()},
      documentId: chatId,
    );
  }

  @override
  Future<void> restoreChatForUser({
    required String chatId,
    required String userId,
  }) async {
    await dataBaseService.updateSingleData(
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
    await dataBaseService.updateSingleData(
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
    await dataBaseService.updateSingleData(
      path: BackendEndPoints.chats,
      data: {"unreadCount.$userId": 0},
      documentId: chatId,
    );
  }

  // ***********************************************************************************************************

  /// message collection

  @override
  Future<void> sendMessage({required MessageEntity message}) async {
    await dataBaseService.addSinleData(
      path: BackendEndPoints.messages,
      documentId: message.id,
      data: MessageModel.formEntity(messageEntity: message).toMap(),
    );

    String chatId = await createOrGetChat(
      user1Id: message.messageSenderId,
      user2Id: message.messageReceiverId,
    );

    await updateChatLastMessage(chatId: chatId, message: message);

    await updateUserLastSeen(userId: message.messageSenderId, chatId: chatId);

    var chatDoc = await dataBaseService.getSingleData(
      path: BackendEndPoints.chats,
      documentId: chatId,
    );

    ChatEntity chat = ChatModel.fromMap(chatDoc).toEntity();

    int currentUnread = chat.getUnreadCount(userId: message.messageReceiverId);

    await updateunReadCount(
      chatId: chatId,
      userId: message.messageReceiverId,
      count: currentUnread + 1,
    );
  }

  @override
  Stream<List<MessageEntity>> getMessagesStream({
    required String user1Id,
    required String user2Id,
  }) async* {
    var data = dataBaseService.getAllDataStream(
      path: BackendEndPoints.messages,
      isQuery: true,
      query: {
        "messageSenderId": [user1Id, user2Id],
        "timeStamp": true,
      },
    );

    List<MessageEntity> messagesList = [];
    await for (var messageMap in data) {
      messagesList = messageMap
          .map((element) => MessageModel.fromMap(element).toEntity())
          .toList();
      yield messagesList;
    }
  }

  @override
  Future<void> markMessageAsRead({required String messageId}) async {
    await dataBaseService.updateSingleData(
      path: BackendEndPoints.messages,
      data: {"isRead": true},
      documentId: messageId,
    );
  }

  @override
  Future<void> deleteMessage({required String messageId}) async {
    await dataBaseService.deleteSingleData(
      path: BackendEndPoints.messages,
      documentId: messageId,
    );
  }

  @override
  Future<void> editMessage({
    required String messageId,
    required String newContent,
  }) async {
    await dataBaseService.updateSingleData(
      path: BackendEndPoints.messages,
      data: {
        "content": newContent,
        "isEdited": true,
        "editedAt": DateTime.now(),
      },
      documentId: messageId,
    );
  }

  // ***********************************************************************************************************

  
}
