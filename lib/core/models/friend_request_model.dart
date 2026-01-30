import 'package:cloud_firestore/cloud_firestore.dart';

enum FriendRequestStatus { pending, accepted, rejected }

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

  factory FriendRequestModel.fromMap(Map<String, dynamic> map) {
    return FriendRequestModel(
      id: map["id"],
      senderId: map["senderId"],
      receiverId: map["receiverId"],
      createdAt: (map["createdAt"] as Timestamp).toDate(),
      responsedAt: (map["responsedAt"] as Timestamp).toDate(),
      message: map["message"],
      status: FriendRequestStatus.values.firstWhere(
        (e) => e.name == (map["status"]),
        orElse: () => FriendRequestStatus.pending,
      ),
    );
  }
}
