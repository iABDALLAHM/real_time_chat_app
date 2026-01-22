import 'package:real_time_chat_app/core/entities/user_entity.dart';

class UserModel {
  final String uId;
  final String email;
  final String displayName;
  String? photoUrl;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime createdAt;

  UserModel({
    required this.uId,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.isOnline = false,
    required this.lastSeen,
    required this.createdAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json["uId"],
      email: json["email"],
      displayName: json["displayName"],
      photoUrl: json["photoUrl"],
      lastSeen: DateTime.fromMicrosecondsSinceEpoch(json["lastSeen"]),
      createdAt: DateTime.fromMicrosecondsSinceEpoch(json["createdAt"]),
    );
  }
  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      uId: userEntity.uId,
      email: userEntity.email,
      displayName: userEntity.displayName,
      photoUrl: userEntity.photoUrl,
      lastSeen: userEntity.lastSeen,
      createdAt: userEntity.createdAt,
    );
  }
  UserEntity toEntity() {
    return UserEntity(
      uId: uId,
      email: email,
      displayName: displayName,
      lastSeen: lastSeen,
      photoUrl: photoUrl,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uId": uId,
      "email": email,
      "displayName": displayName,
      "isOnline": isOnline,
      "lastSeen": lastSeen,
      "createdAt": createdAt,
      "photoUrl": photoUrl,
    };
  }
}
