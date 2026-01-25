import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_time_chat_app/constants.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';
import 'package:real_time_chat_app/core/models/user_model.dart';
import 'package:real_time_chat_app/core/services/auth_service.dart';
import 'package:real_time_chat_app/core/services/data_base_service.dart';
import 'package:real_time_chat_app/core/services/shared_prefs_service.dart';
import 'package:real_time_chat_app/core/utils/backend_end_points.dart';
import 'package:real_time_chat_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImplementation implements AuthRepo {
  final AuthService authService;
  final DataBaseService dataBaseService;

  AuthRepoImplementation({
    required this.authService,
    required this.dataBaseService,
  });
  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      var user =
          await authService.register(
                name: name,
                email: email,
                password: password,
              )
              as User;
      UserEntity userEntity = UserEntity(
        uId: user.uid,
        email: email,
        displayName: name,
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );
      try {
        await addUserData(userEntity: userEntity);
        return Right(userEntity);
      } catch (e) {
        authService.deleteAccount();
        log(
          "error in the AuthRepoImplementation in addUserData method the error is {$e} فشل إضافة المستخدم الي ال dataBase",
        );
        return Left(
          ServerFailure(
            errMessage: "Failed to create account. Please try again.",
          ),
        );
      }
    } on CustomException catch (e) {
      log(
        "error in the AuthRepoImplementation in register method the error is $e",
      );
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var user =
          await authService.signInWithEmailAndPassword(
                password: password,
                email: email,
              )
              as User;
      UserEntity userEntity = await getUserData(uId: user.uid);
      saveUserData(userEntity: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.exceptionMeassge));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await authService.sendPasswordResetEmail(email: email);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<void> addUserData({required UserEntity userEntity}) async {
    await dataBaseService.addData(
      documentId: userEntity.uId,
      path: BackendEndPoints.addUsers,
      data: UserModel.fromEntity(userEntity).toMap(),
    );
  }

  @override
  Future<dynamic> getUserData({required String uId}) async {
    var userMap = await dataBaseService.getData(
      path: BackendEndPoints.getUsers,
      documentId: uId,
    );
    UserEntity userEntity = UserModel.fromMap(userMap).toEntity();
    return userEntity;
  }

  @override
  void saveUserData({required UserEntity userEntity}) {
    var value = jsonEncode(UserModel.fromEntity(userEntity).toJson());
    SharedPrefsService.setData(key: kUserLocalData, value: value);
  }
}
