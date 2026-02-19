import 'package:real_time_chat_app/core/entities/chat_entity.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/entities/friendship_entity.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';

abstract class MainRepo {
  Stream<List<UserEntity>> getAllUsersStream();
  Future<void> sendFriendRequest({required FriendRequestEntity friendRequest});
  Future<void> cancelFriendRequest({required String requestId});
  Future<void> respondToFriendRequest({
    required String requestId,
    required FriendRequestStatus status,
  });
  Stream<List<FriendRequestEntity>> getFriendRequestStream({
    required String userId,
  });
  Stream<List<FriendRequestEntity>> getSentFriendRequestStream({
    required String userId,
  });
  Future<FriendRequestEntity> getFriendRequest({
    required String senderId,
    required String receiverId,
  });

  // friendship collections
  Future<void> createFriendShip({
    required String user1Id,
    required String user2Id,
  });

  Future<void> removeFriendShip({
    required String user1Id,
    required String user2Id,
  });

  Future<void> blockUser({
    required String blockerId,
    required String blockedId,
  });

  Future<void> unBlockUser({required String user1Id, required String user2Id});

  Stream<List<FriendshipEntity>> getFriendsStream({required String userId});

  Future<FriendshipEntity> getFriendShips({
    required String user1Id,
    required String user2Id,
  });

  Future<bool> isUserBlocked({
    required String userId,
    required String otherUserId,
  });

  Future<bool> isUnFriended({
    required String userId,
    required String otherUserId,
  });

  // chats collections
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

  /// message collection
  Future<void> sendMessage({required MessageEntity message});

  /// notifications collection
  Future<void> createNotification({
    required NotificationEntity notificationEntity,
  });

  Future<void> removeNotificationForCancelledRequest({
    required String senderId,
    required String receiverId,
  });

  Future<void> deleteNotificationByTypeAndUser({
    required String userId,
    required NotificationType type,
    required String relatedUserId,
  });
}
