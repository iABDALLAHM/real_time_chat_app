import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';

abstract class ChatsRepo {
  Future<Either<Failure, String>> createOrGetChat({
    required String user1Id,
    required String user2Id,
  });
  Stream<Either<Failure, List<ChatEntity>>> getUserChatsStream({
    required String userId,
  });
  Future<Either<Failure,void>> updateChatLastMessage({
    required String chatId,
    required MessageEntity message,
  });
  Future<Either<Failure, void>> updateUserLastSeen({
    required String chatId,
    required String userId,
  });
  Future<Either<Failure, void>> deleteChatForUser({
    required String chatId,
    required String userId,
  });
  Future<Either<Failure, void>> restoreChatForUser({
    required String chatId,
    required String userId,
  });
  Future<Either<Failure, void>> updateunReadCount({
    required String chatId,
    required String userId,
    required int count,
  });
  Future<Either<Failure, void>> restoreunReadCount({
    required String chatId,
    required String userId,
  });
}
