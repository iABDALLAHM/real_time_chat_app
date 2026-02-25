import 'dart:convert';
import 'package:real_time_chat_app/constants.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
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
  Future<void> signOut({required String userId}) async {
    await authService.signOut();
    SharedPrefsService.setBool(key: kUserLogin, value: false);
    await updateUserOnlineStatus(userId: userId, isOnline: false);
  }

  @override
  Future<void> deleteUser({required String userId}) async {
    await authService.deleteAccount();
    await dataBaseService.deleteSingleData(
      path: BackendEndPoints.deleteUser,
      documentId: userId,
    );
  }

  @override
  Future<void> updateUserInfo({required UserEntity userEntity}) async {
    await dataBaseService.updateSingleData(
      path: BackendEndPoints.updateUser,
      data: UserModel.fromEntity(userEntity).toMap(),
      documentId: userEntity.uId,
    );
    updateUserData(userEntity: userEntity);
  }

  @override
  Future<void> updateUserPassword({required String newPassword}) async {
    await authService.updatePassword(newPassword: newPassword);
    await authService.signOut();
  }

  @override
  void updateUserData({required UserEntity userEntity}) {
    var value = jsonEncode(UserModel.fromEntity(userEntity).toJson());
    SharedPrefsService.setData(key: kUserLocalData, value: value);
  }

  @override
  Stream<UserEntity> getUserStream({required String uId}) async* {
    await for (var (result) in dataBaseService.getSingleDataStream(
      uId: uId,
      path: BackendEndPoints.getUsers,
    )) {
      final map = result as Map<String, dynamic>;
      var data = UserModel.fromMap(map).toEntity();
      yield data;
    }
  }

  @override
  Future<void> updateUserOnlineStatus({
    required String userId,
    required bool isOnline,
  }) async {
    await dataBaseService.updateSingleData(
      documentId: userId,
      path: BackendEndPoints.getUsers,
      data: {"isOnline": isOnline, "lastSeen": DateTime.now()},
    );
  }
}
