import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, void>> createNotification({
    required NotificationEntity notificationEntity,
  });

  Stream<Either<Failure, List<NotificationEntity>>> getNotificationsStream({
    required String userId,
  });

  Future<Either<Failure, void>> markNotificationAsRead({
    required String notificationId,
  });

  Future<Either<Failure, void>> markAllNotificationAsRead({
    required String userId,
  });

  Future<Either<Failure, void>> deleteNotification({
    required String notificationId,
  });

  Future<Either<Failure, void>> removeNotificationForCancelledRequest({
    required String senderId,
    required String receiverId,
  });

  Future<Either<Failure, void>> deleteNotificationByTypeAndUser({
    required String userId,
    required NotificationType type,
  });
}
