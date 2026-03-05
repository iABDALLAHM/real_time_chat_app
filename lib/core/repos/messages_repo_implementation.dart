import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';
import 'package:real_time_chat_app/core/models/chat_model.dart';
import 'package:real_time_chat_app/core/models/firestore_query.dart';
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
  Future<Either<Failure, void>> sendMessage({
    required MessageEntity message,
  }) async {
    try {
      await dataBaseService.addSinleData(
        path: BackendEndPoints.messages,
        documentId: message.id,
        data: MessageModel.formEntity(messageEntity: message).toMap(),
      );

      String chatId =
          await chatsRepo.createOrGetChat(
                user1Id: message.messageSenderId,
                user2Id: message.messageReceiverId,
              )
              as String;

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

      int currentUnread = chat.getUnreadCount(
        userId: message.messageReceiverId,
      );

      await chatsRepo.updateunReadCount(
        chatId: chatId,
        userId: message.messageReceiverId,
        count: currentUnread + 1,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this Error is happend in MessagesRepoImplementation in send Message Method the error is ${e.exceptionMeassge}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessagesStream({
    required String user1Id,
    required String user2Id,
  }) async* {
    try {
      List<String> users = [user1Id, user2Id];
      users.sort();
      var messagesChatId = "${users[0]}_${users[1]}";
      var data = dataBaseService.getAllDataQueryStream(
        path: BackendEndPoints.messages,
        query: QueryParams(
          conditions: [
            QueryCondition(field: "participants", isEqualTo: messagesChatId),
          ],
          orders: [QueryOrder(field: "timeStamp", descending: true)],
        ),
      );

      List<MessageEntity> messagesList = [];
      await for (var messageMap in data) {
        messagesList = messageMap
            .map((element) => MessageModel.fromMap(element).toEntity())
            .toList();
      }
      yield Right(messagesList);
    } on CustomException catch (e) {
      log(
        "this Error is happend in MessagesRepoImplementation in get Messages Stream Method the error is ${e.exceptionMeassge}",
      );
      yield Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> markMessageAsRead({
    required String messageId,
  }) async {
    try {
      await dataBaseService.updateSingleData(
        path: BackendEndPoints.messages,
        data: {"isRead": true},
        documentId: messageId,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this Error is happend in MessagesRepoImplementation in mark Message As Read Method the error is ${e.exceptionMeassge}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage({
    required String messageId,
  }) async {
    try {
      await dataBaseService.deleteSingleData(
        path: BackendEndPoints.messages,
        documentId: messageId,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this Error is happend in MessagesRepoImplementation in delete Message Method the error is ${e.exceptionMeassge}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> editMessage({
    required String messageId,
    required String newContent,
  }) async {
    try {
      await dataBaseService.updateSingleData(
        path: BackendEndPoints.messages,
        data: {
          "content": newContent,
          "isEdited": true,
          "editedAt": DateTime.now(),
        },
        documentId: messageId,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this Error is happend in MessagesRepoImplementation in edit Message Method the error is ${e.exceptionMeassge}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }
}
