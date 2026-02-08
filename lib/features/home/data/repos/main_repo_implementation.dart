// import 'package:real_time_chat_app/core/entities/chat_entity.dart';
// import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
// import 'package:real_time_chat_app/core/entities/friendship_entity.dart';
// import 'package:real_time_chat_app/core/entities/message_entity.dart';
// import 'package:real_time_chat_app/core/entities/notification_entity.dart';
// import 'package:real_time_chat_app/core/entities/user_entity.dart';
// import 'package:real_time_chat_app/core/models/chat_model.dart';
// import 'package:real_time_chat_app/core/models/friend_request_model.dart';
// import 'package:real_time_chat_app/core/models/friendship_model.dart';
// import 'package:real_time_chat_app/core/models/message_model.dart';
// import 'package:real_time_chat_app/core/models/user_model.dart';
// import 'package:real_time_chat_app/core/services/data_base_service.dart';
// import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
// import 'package:real_time_chat_app/features/home/domain/repos/main_repo.dart';

// class MainRepoImplementation implements MainRepo {
//   final DataBaseService dataBaseService;
//   MainRepoImplementation({required this.dataBaseService});

//   @override
//   Stream<List<UserEntity>> getAllUsersStream() async* {
//     List<UserEntity> usersList = [];
//     var usersSnapshots = dataBaseService.getAllDataStream(
//       path: BackendEndPoints.getUsers,
//     );
//     for (var user in (usersSnapshots as List<Map<String, dynamic>>)) {
//       usersList.add(UserModel.fromMap(user).toEntity());
//     }
//     yield usersList;
//   }

//   @override
//   Future<void> sendFriendRequest({required FriendRequestEntity request}) async {
//     dataBaseService.addData(
//       path: BackendEndPoints.addFriendRequests,
//       documentId: request.id,
//       data: FriendRequestModel.fromEntity(friendRequestEntity: request).toMap(),
//     );
//     String notificationId =
//         "friend_request_${request.senderId}_${request.receiverId}_${DateTime.now()}";
//     await createNotification(
//       NotificationEntity(
//         id: notificationId,
//         userId: request.receiverId,
//         title: "New Friend Request",
//         body: "You have recevied a new friend request",
//         data: {"senderId": request.senderId, "requestId": request.id},
//         type: NotificationType.friendRequest,
//         createdAt: DateTime.now(),
//       ),
//     );
//   }

//   @override
//   Future<void> cancelFriendRequest({required String requestId}) async {
//     var requestDoc = await dataBaseService.getData(
//       path: BackendEndPoints.getFriendRequests,
//       documentId: requestId,
//     );
//     FriendRequestEntity friendRequestEntity = FriendRequestModel.fromMap(
//       requestDoc,
//     ).toEntity();

//     await dataBaseService.deleteData(
//       path: BackendEndPoints.deleteRequests,
//       documentId: requestId,
//     );

//     await deleteNotificationByTypeAndUser(
//       friendRequestEntity.receiverId,
//       NotificationType.friendRequest,
//       friendRequestEntity.senderId,
//     );
//   }

//   @override
//   Future<void> respondToFriendRequest({
//     required String requestId,
//     required FriendRequestStatus status,
//   }) async {
//     await dataBaseService.updateData(
//       path: BackendEndPoints.updateRequests,
//       data: {"status": status.name, "responsedAt": DateTime.now()},
//     );

//     var requestDoc = await dataBaseService.getData(
//       path: BackendEndPoints.getFriendRequests,
//       documentId: requestId,
//     );

//     FriendRequestEntity friendRequestEntity = FriendRequestModel.fromMap(
//       requestDoc,
//     ).toEntity();

//     if (status == FriendRequestStatus.accepted) {
//       await createFriendShip(
//         friendRequestEntity.senderId,
//         friendRequestEntity.receiverId,
//       );

//       await createNotification(
//         NotificationEntity(
//           id: DateTime.now().toString(),
//           userId: friendRequestEntity.senderId,
//           data: {"userId": friendRequestEntity.receiverId},
//           title: "Friend Request Accepted",
//           body: "Your friend request has been accepted",
//           type: NotificationType.friendRequestAccepted,
//           createdAt: DateTime.now(),
//         ),
//       );

//       await removeNotificationFromCancelledRequest(
//         friendRequestEntity.receiverId,
//         friendRequestEntity.senderId,
//       );
//     } else if (status == FriendRequestStatus.rejected) {
//       await createNotification(
//         NotificationEntity(
//           id: DateTime.now().toString(),
//           userId: friendRequestEntity.senderId,
//           data: {"userId": friendRequestEntity.receiverId},
//           title: "Friend Request declined",
//           body: "Your friend request has been declined",
//           type: NotificationType.friendRequestDecliend,
//           createdAt: DateTime.now(),
//         ),
//       );

//       await removeNotificationFromCancelledRequest(
//         friendRequestEntity.receiverId,
//         friendRequestEntity.senderId,
//       );
//     }
//   }

//   @override
//   Stream<List<FriendRequestEntity>> getFriendRequestStream({
//     required String userId,
//   }) async* {
//     // not good implementation !!!!!

//     // var data = dataBaseService.getAllDataStream(
//     //   path: BackendEndPoints.getFriendRequests,
//     //   isQuery: true,
//     //   query: {
//     //     "receiverId" : userId,
//     //     "status" : "pending",
//     //     "createdAt" : true,
//     //   },
//     // );
//   }

//   @override
//   Stream<List<FriendRequestEntity>> getSentFriendRequestStream({
//     required String userId,
//   }) async* {}

//   @override
//   Future<FriendRequestEntity> getFriendRequest({
//     required String userId,
//     required String receiverId,
//   }) async {
//     ////
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> createFriendShip({
//     required String user1Id,
//     required String user2Id,
//   }) async {
//     List<String> userIds = [user1Id, user2Id];
//     userIds.sort();
//     String friendShipId = "${userIds[0]}_ ${userIds[1]}";

//     FriendshipModel friendshipModel = FriendshipModel.fromEntity(
//       friendshipEntity: FriendshipEntity(
//         id: friendShipId,
//         user1Id: userIds[0],
//         user2Id: userIds[1],
//         createdAt: DateTime.now(),
//       ),
//     );

//     await dataBaseService.addData(
//       path: BackendEndPoints.addFriendShips,
//       data: friendshipModel.toMap(),
//       documentId: friendShipId,
//     );
//   }

//   @override
//   Future<void> removeFriendShip({
//     required String user1Id,
//     required String user2Id,
//   }) async {
//     List<String> userIds = [user1Id, user2Id];
//     userIds.sort();
//     String friendShipId = "${userIds[0]}_ ${userIds[1]}";

//     await dataBaseService.deleteData(
//       path: BackendEndPoints.deleteFriendShips,
//       documentId: friendShipId,
//     );

//     await createNotification(
//       NotificationEntity(
//         id: DateTime.now().toString(),
//         userId: user2Id,
//         data: {"userId": user1Id},
//         title: "Friend Removed",
//         body: "Your are not longer friends",
//         type: NotificationType.friendRemoved,
//         createdAt: DateTime.now(),
//       ),
//     );
//   }

//   @override
//   Future<void> blockUser({
//     required String blockerId,
//     required String blockedId,
//   }) async {
//     List<String> userIds = [blockerId, blockedId];
//     userIds.sort();
//     String friendShipId = "${userIds[0]}_ ${userIds[1]}";

//     await dataBaseService.updateData(
//       path: BackendEndPoints.updateFriendShips,
//       data: {"isBlocked": true, "blockedBy": blockerId},
//       documentId: friendShipId,
//     );
//   }

//   @override
//   Future<void> unBlockUser({
//     required String user1Id,
//     required String user2Id,
//   }) async {
//     List<String> userIds = [user1Id, user2Id];
//     userIds.sort();
//     String friendShipId = "${userIds[0]}_ ${userIds[1]}";

//     await dataBaseService.updateData(
//       path: BackendEndPoints.updateFriendShips,
//       data: {"isBlocked": false, "blockedBy": null},
//       documentId: friendShipId,
//     );
//   }

//   @override
//   Stream<List<FriendshipEntity>> getFriendsStream(String userId) {
//     // TODO: implement getFriendsStream
//     throw UnimplementedError();
//   }

//   @override
//   Future<FriendshipEntity> getFriendShips({
//     required String user1Id,
//     required String user2Id,
//   }) async {
//     List<String> userIds = [user1Id, user2Id];
//     userIds.sort();
//     String friendShipId = "${userIds[0]}_ ${userIds[1]}";

//     var doc = await dataBaseService.getData(
//       path: BackendEndPoints.getFriendShips,
//       documentId: friendShipId,
//     );
//     FriendshipEntity friendshipEntity = FriendshipModel.fromMap(doc).toEntity();
//     return friendshipEntity;
//   }

//   @override
//   Future<bool> isUserBlocked({
//     required String userId,
//     required String otherUserId,
//   }) async {
//     List<String> userIds = [userId, otherUserId];
//     userIds.sort();
//     String friendShipId = "${userIds[0]}_ ${userIds[1]}";

//     var doc = await dataBaseService.getData(
//       path: BackendEndPoints.getFriendShips,
//       documentId: friendShipId,
//     );

//     FriendshipEntity friendshipEntity = FriendshipModel.fromMap(doc).toEntity();
//     return friendshipEntity.isBlocked;
//   }

//   @override
//   Future<bool> isUnFriended({
//     required String userId,
//     required String otherUserId,
//   }) async {
//     List<String> userIds = [userId, otherUserId];
//     userIds.sort();
//     String friendShipId = "${userIds[0]}_ ${userIds[1]}";

//     var doc = await dataBaseService.getData(
//       path: BackendEndPoints.getFriendShips,
//       documentId: friendShipId,
//     );

//     if (doc != null) {
//       return true;
//     }

//     return false;
//   }

//   @override
//   Future<String> createOrGetChat({
//     required String user1Id,
//     required String user2Id,
//   }) async {
//     List<String> participants = [user1Id, user2Id];
//     participants.sort();
//     String chatId = "${participants[0]}_${participants[1]}";
//     var chatRefernce = await dataBaseService.getData(
//       path: BackendEndPoints.getChats,
//       documentId: chatId,
//     );
//     if (chatRefernce == null) {
//       ChatEntity newChat = ChatEntity(
//         id: chatId,
//         participants: participants,
//         unreadCount: {user1Id: 0, user2Id: 0},
//         deletedBy: {user1Id: false, user2Id: false},
//         deletedAt: {user1Id: null, user2Id: null},
//         lastSeenBy: {user1Id: DateTime.now(), user2Id: DateTime.now()},
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );
//       await dataBaseService.addData(
//         path: BackendEndPoints.addChats,
//         data: ChatModel.fromEntity(chatEntity: newChat).toMap(),
//       );
//     } else {
//       ChatEntity existingChat = ChatModel.fromMap(chatRefernce).toEntity();

//       if (existingChat.isDeletedBy(userId: user1Id)) {
//         await restoreChatForUser(chatId, user1Id);
//       }

//       if (existingChat.isDeletedBy(userId: user2Id)) {
//         await restoreChatForUser(chatId, user2Id);
//       }
//     }
//     return chatId;
//   }

//   @override
//   Stream<List<ChatEntity>> getUserChatsStream({required String userId}) async* {
//     // here is query
//   }

//   @override
//   Future<void> updateChatLastMessage({
//     required String chatId,
//     required MessageEntity message,
//   }) async {
//     dataBaseService.updateData(
//       path: BackendEndPoints.updateChats,
//       data: {
//         "lastMessage": message.content,
//         "lastMessageTime": message,
//         "lastMessageSenderId": message.senderId,
//         "updatedAt": DateTime.now(),
//       },
//       documentId: chatId,
//     );
//   }

//   @override
//   Future<void> updateUserLastSeen({
//     required String chatId,
//     required String userId,
//   }) async {
//     await dataBaseService.updateData(
//       path: BackendEndPoints.getChats,
//       data: {"lastSeenBy.$userId": DateTime.now()},
//       documentId: chatId,
//     );
//   }

//   @override
//   Future<void> deleteChatForUser({
//     required String chatId,
//     required String userId,
//   }) async {
//     await dataBaseService.updateData(
//       path: BackendEndPoints.deleteChats,
//       data: {"deletedBy.$userId": true, "deletedAt.$userId": DateTime.now()},
//       documentId: chatId,
//     );
//   }

//   @override
//   Future<void> restoreChatForUser({
//     required String chatId,
//     required String userId,
//   }) async {
//     await dataBaseService.updateData(
//       path: BackendEndPoints.chats,
//       data: {"deletedBy.$userId": false},
//       documentId: chatId,
//     );
//   }

//   @override
//   Future<void> updateunReadCount({
//     required String chatId,
//     required String userId,
//     required int count,
//   }) async {
//     await dataBaseService.updateData(
//       path: BackendEndPoints.chats,
//       data: {"unreadCount.$userId": count},
//       documentId: chatId,
//     );
//   }

//   @override
//   Future<void> restoreunReadCount({
//     required String chatId,
//     required String userId,
//   }) async {
//     await dataBaseService.updateData(
//       path: BackendEndPoints.chats,
//       data: {"unreadCount.$userId": 0},
//       documentId: chatId,
//     );
//   }

//   @override
//   Future<void> sendMessage({required MessageEntity message}) async {
//     await dataBaseService.addData(
//       path: BackendEndPoints.messages,
//       data: MessageModel.formEntity(messageEntity: message).toMap(),
//       documentId: message.id,
//     );

//     String chatId = await createOrGetChat(
//       user1Id: message.senderId,
//       user2Id: message.receiverId,
//     );
//     await updateChatLastMessage(chatId: chatId, message: message);
//     await updateUserLastSeen(userId: message.senderId, chatId: chatId);

//     var chatDoc = await dataBaseService.getData(
//       path: BackendEndPoints.chats,
//       documentId: chatId,
//     );
//     // MessageEntity messageEntity = MessageModel.fromMap(chatDoc).toEntity();
//     // int currentUnread = messageEntity.get
//   }
// }
 
//  // 58:00