import 'package:cloud_firestore/cloud_firestore.dart';

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
}
