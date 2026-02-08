import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/entities/friendship_entity.dart';

class FriendshipModel {
  final String id;
  final String user1Id;
  final String user2Id;
  final DateTime createdAt;
  final bool isBlocked;
  final String? blockedBy;

  FriendshipModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.createdAt,
    this.isBlocked = false,
    this.blockedBy,
  });
  factory FriendshipModel.fromMap(Map<String, dynamic> map) {
    return FriendshipModel(
      id: map["id"],
      user1Id: map["user1Id"],
      user2Id: map["user2Id"],
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
      user1Id: friendshipEntity.user1Id,
      user2Id: friendshipEntity.user2Id,
      createdAt: (friendshipEntity.createdAt as Timestamp).toDate(),
      isBlocked: friendshipEntity.isBlocked,
      blockedBy: friendshipEntity.blockedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "user1Id": user1Id,
      "user2Id": user2Id,
      "createdAt": createdAt,
      "isBlocked": isBlocked,
      "blockedBy": blockedBy,
    };
  }

  FriendshipEntity toEntity() {
    return FriendshipEntity(
      id: id,
      user1Id: user1Id,
      user2Id: user2Id,
      createdAt: createdAt,
      isBlocked: isBlocked,
      blockedBy: blockedBy,
    );
  }

  String getOtherUserId({required String currentUserId}) {
    return currentUserId == user1Id ? user2Id : user1Id;
  }

  bool isBlockedBy({required String userId}) {
    return isBlocked && blockedBy == userId;
  }
}
