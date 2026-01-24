import 'dart:convert';
import 'package:real_time_chat_app/constants.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/models/user_model.dart';
import 'package:real_time_chat_app/core/services/shared_prefs_service.dart';

UserEntity getUserData() {
  var localData = SharedPrefsService.getData(key: kUserLocalData);
  UserEntity userEntity = UserModel.fromJson(jsonDecode(localData)).toEntity();
  return userEntity;
}
