import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/entities/friendship_entity.dart';

class FriendshipModel {
  final String id;
  final List<String> userIds;
  final DateTime createdAt;
  bool isBlocked;
  String? blockedBy;

  FriendshipModel({
    required this.id,
    required this.userIds,
    required this.createdAt,
    this.isBlocked = false,
    this.blockedBy,
  });
  factory FriendshipModel.fromMap(Map<String, dynamic> map) {
    return FriendshipModel(
      userIds: List<String>.from(map["userIds"]),
      id: map["id"],
      createdAt: (map["createdAt"] as Timestamp).toDate(),
      isBlocked: map["isBlocked"],
      blockedBy: map["blockedBy"],
    );
  }

  factory FriendshipModel.fromEntity({
    required FriendshipEntity friendshipEntity,
  }) {
    return FriendshipModel(
      id: friendshipEntity.id,
      userIds: friendshipEntity.userIds,
      createdAt: (friendshipEntity.createdAt as Timestamp).toDate(),
      isBlocked: friendshipEntity.isBlocked,
      blockedBy: friendshipEntity.blockedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userIds": userIds,
      "createdAt": createdAt,
      "isBlocked": isBlocked,
      "blockedBy": blockedBy,
    };
  }

  FriendshipEntity toEntity() {
    return FriendshipEntity(
      id: id,
      userIds: userIds,
      createdAt: createdAt,
      isBlocked: isBlocked,
      blockedBy: blockedBy,
    );
  }
}
