import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/models/chat_model.dart';
import 'package:real_time_chat_app/core/models/firestore_query.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/home/domain/repos/chats_repo.dart';

class ChatsRepoImplementation implements ChatsRepo {
  final DataBaseService dataBaseService;

  ChatsRepoImplementation({required this.dataBaseService});
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
    var data = dataBaseService.getAllDataQueryStream(
      path: BackendEndPoints.chats,
      query: FirestoreQuery(
        conditions: [QueryCondition(field: "participants", isEqualTo: userId)],
        orders: [QueryOrder(field: "updatedAt", descending: true)],
      ),
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
}
