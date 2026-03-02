import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/models/chat_model.dart';
import 'package:real_time_chat_app/core/models/message_model.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/home/domain/repos/chats_repo.dart';
import 'package:real_time_chat_app/core/repos/messages_repo.dart';

class MessagesRepoImplementation implements MessagesRepo {
  final DataBaseService dataBaseService;
  final ChatsRepo chatsRepo;

  MessagesRepoImplementation({
    required this.dataBaseService,
    required this.chatsRepo,
  });

  @override
  Future<void> sendMessage({required MessageEntity message}) async {
    await dataBaseService.addSinleData(
      path: BackendEndPoints.messages,
      documentId: message.id,
      data: MessageModel.formEntity(messageEntity: message).toMap(),
    );

    String chatId = await chatsRepo.createOrGetChat(
      user1Id: message.messageSenderId,
      user2Id: message.messageReceiverId,
    );

    await chatsRepo.updateChatLastMessage(chatId: chatId, message: message);

    await chatsRepo.updateUserLastSeen(
      userId: message.messageSenderId,
      chatId: chatId,
    );

    var chatDoc = await dataBaseService.getSingleData(
      path: BackendEndPoints.chats,
      documentId: chatId,
    );

    ChatEntity chat = ChatModel.fromMap(chatDoc).toEntity();

    int currentUnread = chat.getUnreadCount(userId: message.messageReceiverId);

    await chatsRepo.updateunReadCount(
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
}
