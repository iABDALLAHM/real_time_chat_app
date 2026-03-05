import 'package:dartz/dartz.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/errors/failure.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> signOut({required String userId});
  Future<Either<Failure, void>> deleteUser({required String userId});
  Future<Either<Failure, void>> updateUserInfo({
    required UserEntity userEntity,
  });
  Future<Either<Failure, void>> updateUserPassword({
    required String newPassword,
  });
  void updateUserData({required UserEntity userEntity});
  Stream<Either<Failure, UserEntity>> getUserStream({required String uId});
  Future<Either<Failure, void>> updateUserOnlineStatus({
    required String userId,
    required bool isOnline,
  });
}
