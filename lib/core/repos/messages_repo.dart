import 'package:real_time_chat_app/core/entities/message_entity.dart';

abstract class MessagesRepo {
  /// message collection
  Future<void> sendMessage({required MessageEntity message});

  Stream<List<MessageEntity>> getMessagesStream({
    required String user1Id,
    required String user2Id,
  });

  Future<void> markMessageAsRead({required String messageId});

  Future<void> deleteMessage({required String messageId});
  Future<void> editMessage({
    required String messageId,
    required String newContent,
  });
}
