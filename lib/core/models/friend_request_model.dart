import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/entities/friend_request_entity.dart';
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';

class FriendRequestModel {
  final String id;
  final String senderId;
  final String receiverId;
  final FriendRequestStatus status;
  final DateTime createdAt;
  final DateTime? responsedAt;
  final String? message;

  FriendRequestModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.status = FriendRequestStatus.pending,
    required this.createdAt,
    this.responsedAt,
    this.message,
  });

  factory FriendRequestModel.fromMap(Map<String, dynamic> map) {
    return FriendRequestModel(
      id: map["id"],
      senderId: map["senderId"],
      receiverId: map["receiverId"],
      createdAt: (map["createdAt"] as Timestamp).toDate(),
      // responsedAt: (map["responsedAt"] as Timestamp).toDate() ? DateTime) ,
      // message: map["message"],
      status: FriendRequestStatus.values.firstWhere(
        (e) => e.name == (map["status"]),
        orElse: () => FriendRequestStatus.pending,
      ),
    );
  }

  factory FriendRequestModel.fromEntity({
    required FriendRequestEntity friendRequestEntity,
  }) {
    return FriendRequestModel(
      id: friendRequestEntity.id,
      senderId: friendRequestEntity.senderId,
      receiverId: friendRequestEntity.receiverId,
      createdAt: friendRequestEntity.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "status": status.name,
      "createdAt": createdAt,
      "responsedAt": responsedAt,
      "message": message,
    };
  }

  FriendRequestEntity toEntity() {
    return FriendRequestEntity(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      createdAt: createdAt,
      status: status,
      responsedAt: responsedAt,
      message: message,
    );
  }
}
