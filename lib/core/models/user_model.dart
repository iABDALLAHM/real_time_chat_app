import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uId: json["uId"],
      email: json["email"],
      displayName: json["displayName"],
      photoUrl: json["photoUrl"] ?? "",
      lastSeen: (json["lastSeen"] as Timestamp).toDate(),
      createdAt: (json["createdAt"] as Timestamp).toDate(),
    );
  }
  
  // This is a specific to the case of the get data in adevice localy
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json["uId"],
      email: json["email"],
      displayName: json["displayName"],
      photoUrl: json["photoUrl"] ?? "",
      lastSeen: DateTime.fromMillisecondsSinceEpoch(json["lastSeen"]),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
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

  // This is a specific to the case of the save data in adevice localy
  Map<String, dynamic> toJson() {
    return {
      "uId": uId,
      "email": email,
      "displayName": displayName,
      "lastSeen": lastSeen.millisecondsSinceEpoch,
      "createdAt": createdAt.millisecondsSinceEpoch,
    };
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
