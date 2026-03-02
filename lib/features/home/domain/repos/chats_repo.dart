import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';

abstract class ChatsRepo {
  Future<String> createOrGetChat({
    required String user1Id,
    required String user2Id,
  });
  Stream<List<ChatEntity>> getUserChatsStream({required String userId});
  Future<void> updateChatLastMessage({
    required String chatId,
    required MessageEntity message,
  });
  Future<void> updateUserLastSeen({
    required String chatId,
    required String userId,
  });
  Future<void> deleteChatForUser({
    required String chatId,
    required String userId,
  });
  Future<void> restoreChatForUser({
    required String chatId,
    required String userId,
  });
  Future<void> updateunReadCount({
    required String chatId,
    required String userId,
    required int count,
  });
  Future<void> restoreunReadCount({
    required String chatId,
    required String userId,
  });
}
