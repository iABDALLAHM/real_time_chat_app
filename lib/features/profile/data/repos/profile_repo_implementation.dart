import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/constants.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';
import 'package:real_time_chat_app/core/models/user_model.dart';
import 'package:real_time_chat_app/core/services/auth_service.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/services/shared_prefs_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImplementation implements ProfileRepo {
  final AuthService authService;
  final DataBaseService dataBaseService;

  ProfileRepoImplementation({
    required this.authService,
    required this.dataBaseService,
  });

  @override
  Future<Either<Failure, void>> signOut({required String userId}) async {
    try {
      await authService.signOut();
      SharedPrefsService.setBool(key: kUserLogin, value: false);
      await updateUserOnlineStatus(userId: userId, isOnline: false);
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in ProfileRepoImplementation in signOut method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser({required String userId}) async {
    try {
      await authService.deleteAccount();
      await dataBaseService.deleteSingleData(
        path: BackendEndPoints.deleteUser,
        documentId: userId,
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in ProfileRepoImplementation in deleteUser method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserInfo({
    required UserEntity userEntity,
  }) async {
    try {
      await dataBaseService.updateSingleData(
        path: BackendEndPoints.updateUser,
        data: UserModel.fromEntity(userEntity).toMap(),
        documentId: userEntity.uId,
      );
      updateUserData(userEntity: userEntity);
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in ProfileRepoImplementation in updateUserInfo method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserPassword({
    required String newPassword,
  }) async {
    try {
      await authService.updatePassword(newPassword: newPassword);
      await authService.signOut();
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in ProfileRepoImplementation in updateUserPassword method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  void updateUserData({required UserEntity userEntity}) {
    var value = jsonEncode(UserModel.fromEntity(userEntity).toJson());
    SharedPrefsService.setData(key: kUserLocalData, value: value);
  }

  @override
  Stream<Either<Failure, UserEntity>> getUserStream({
    required String uId,
  }) async* {
    try {
      await for (var (result) in dataBaseService.getSingleDataStream(
        uId: uId,
        path: BackendEndPoints.getUsers,
      )) {
        final map = result as Map<String, dynamic>;
        var data = UserModel.fromMap(map).toEntity();
        yield Right(data);
      }
    } on CustomException catch (e) {
      log(
        "this error happend in ProfileRepoImplementation in getUserStream method ${e.toString()}",
      );
      yield Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserOnlineStatus({
    required String userId,
    required bool isOnline,
  }) async {
    try {
      await dataBaseService.updateSingleData(
        documentId: userId,
        path: BackendEndPoints.getUsers,
        data: {"isOnline": isOnline, "lastSeen": DateTime.now()},
      );
      return Right(null);
    } on CustomException catch (e) {
      log(
        "this error happend in ProfileRepoImplementation in updateUserOnlineStatus method ${e.toString()}",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }
}
