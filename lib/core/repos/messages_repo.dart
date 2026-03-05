import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';

abstract class MessagesRepo {
  /// message collection
  Future<Either<Failure, void>> sendMessage({required MessageEntity message});

  Stream<Either<Failure, List<MessageEntity>>> getMessagesStream({
    required String user1Id,
    required String user2Id,
  });

  Future<Either<Failure, void>> markMessageAsRead({required String messageId});

  Future<Either<Failure, void>> deleteMessage({required String messageId});
  Future<Either<Failure, void>> editMessage({
    required String messageId,
    required String newContent,
  });
}
