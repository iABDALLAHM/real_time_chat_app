// notifications collection all done

import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/notification_entity.dart';
import 'package:real_time_chat_app/core/enums/notification_type.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';
import 'package:real_time_chat_app/core/models/firestore_query.dart';
import 'package:real_time_chat_app/core/models/notification_model.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/home/domain/repos/notifications_repo.dart';

class NotificationsRepoImplementation implements NotificationsRepo {
  final DataBaseService dataBaseService;

  NotificationsRepoImplementation({required this.dataBaseService});
  @override
  Future<Either<Failure, void>> createNotification({
    required NotificationEntity notificationEntity,
  }) async {
    try {
      await dataBaseService.addSinleData(
        path: BackendEndPoints.notification,
        data: NotificationModel.fromEntity(
          notificationEntity: notificationEntity,
        ).toMap(),
        documentId: notificationEntity.id,
      );
      return Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> removeNotificationForCancelledRequest({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      await deleteNotificationByTypeAndUser(
        userId: receiverId,
        type: NotificationType.friendRequest,
      );
      return Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotificationByTypeAndUser({
    required String userId,
    required NotificationType type,
  }) async {
    try {
      await dataBaseService.deleteBatchData(
        path: BackendEndPoints.notification,
        query: QueryParams(
          conditions: [
            QueryCondition(field: "userId", isEqualTo: userId),
            QueryCondition(field: "type", isEqualTo: type.name),
          ],
          orders: [],
        ),
      );
      return Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Stream<Either<Failure, List<NotificationEntity>>> getNotificationsStream({
    required String userId,
  }) async* {
    try {
      var data = dataBaseService.getAllDataQueryStream(
        path: BackendEndPoints.notification,
        query: QueryParams(
          conditions: [QueryCondition(field: "userId", isEqualTo: userId)],
          orders: [QueryOrder(field: "createdAt", descending: true)],
        ),
      );
      await for (var notificationMap in data) {
        List<NotificationEntity> notificationList = notificationMap
            .map((ele) => NotificationModel.fromMap(ele).toEntity())
            .toList();

        yield Right(notificationList);
      }
    } on CustomException catch (e) {
      yield Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> markNotificationAsRead({
    required String notificationId,
  }) async {
    try {
      await dataBaseService.updateSingleData(
        path: BackendEndPoints.notification,
        data: {"isRead": true},
        documentId: notificationId,
      );
      return Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> markAllNotificationAsRead({
    required String userId,
  }) async {
    try {
      await dataBaseService.updateBatchData(
        updatedData: {"isRead": true},
        path: BackendEndPoints.notification,
        query: QueryParams(
          conditions: [
            QueryCondition(field: "userId", isEqualTo: userId),
            QueryCondition(field: "isRead", isEqualTo: false),
          ],
          orders: [],
        ),
      );
      return Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification({
    required String notificationId,
  }) async {
    try {
      await dataBaseService.deleteSingleData(
        path: BackendEndPoints.notification,
        documentId: notificationId,
      );
      return Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }
}
