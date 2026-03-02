// notifications collection all done

import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/models/notification_model.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/home/domain/repos/notifications_repo.dart';

class NotificationsRepoImplementation implements NotificationsRepo {
  final DataBaseService dataBaseService;

  NotificationsRepoImplementation({required this.dataBaseService});
  @override
  Future<void> createNotification({
    required NotificationEntity notificationEntity,
  }) async {
    await dataBaseService.addSinleData(
      path: BackendEndPoints.notification,
      data: NotificationModel.fromEntity(
        notificationEntity: notificationEntity,
      ).toMap(),
      documentId: notificationEntity.id,
    );
  }

  @override
  Future<void> removeNotificationForCancelledRequest({
    required String senderId,
    required String receiverId,
  }) async {
    await deleteNotificationByTypeAndUser(
      userId: receiverId,
      type: NotificationType.friendRequest,
      relatedUserId: senderId,
    );
  }

  @override
  Future<void> deleteNotificationByTypeAndUser({
    required String userId,
    required NotificationType type,
    required String relatedUserId,
  }) async {
    await dataBaseService.getQueryData(
      path: BackendEndPoints.notification,
      relatedId: relatedUserId,
      query: {"userId": userId, "type": type.name},
      isQuery: true,
    );
  }

  @override
  Stream<List<NotificationEntity>> getNotificationsStream({
    required String userId,
  }) async* {
    var data = dataBaseService.getAllDataStream(
      path: BackendEndPoints.notification,
      isQuery: true,
      query: {"userId": userId, "createdAt": true},
    );
    await for (var notificationMap in data) {
      List<NotificationEntity> notificationList = notificationMap
          .map((ele) => NotificationModel.fromMap(ele).toEntity())
          .toList();

      yield notificationList;
    }
  }

  @override
  Future<void> markNotificationAsRead({required String notificationId}) async {
    await dataBaseService.updateSingleData(
      path: BackendEndPoints.notification,
      data: {"isRead": true},
      documentId: notificationId,
    );
  }

  @override
  Future<void> markAllNotificationAsRead({required String userId}) async {
    await dataBaseService.getQueryData(
      query: {"userId": userId, "isRead": false},
      isQuery: true,
      path: BackendEndPoints.notification,
    );
  }

  @override
  Future<void> deleteNotification({required String notificationId}) async {
    await dataBaseService.deleteSingleData(
      path: BackendEndPoints.notification,
      documentId: notificationId,
    );
  }
}
