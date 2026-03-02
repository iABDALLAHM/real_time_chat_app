  import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
abstract class NotificationsRepo {
  
/// notifications collection
  Future<void> createNotification({
    required NotificationEntity notificationEntity,
  });

  Stream<List<NotificationEntity>> getNotificationsStream({
    required String userId,
  });

  Future<void> markNotificationAsRead({required String notificationId});

  Future<void> markAllNotificationAsRead({required String userId});

  Future<void> deleteNotification({required String notificationId});

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