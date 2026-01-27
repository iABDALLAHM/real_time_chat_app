import 'package:real_time_chat_app/core/entities/user_entity.dart';

abstract class ProfileRepo {
  Future<void> signOut({required String userId});
  Future<void> deleteUser({required String userId});
  Future<void> updateUserInfo({required UserEntity userEntity});
}
