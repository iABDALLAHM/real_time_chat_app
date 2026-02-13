
import 'package:real_time_chat_app/core/enums/friend_request_status.dart';

class FriendRequestEntity {
  final String id;
  final String senderId;
  final String receiverId;
  final FriendRequestStatus status;
  final DateTime createdAt;
  final DateTime? responsedAt;
  final String? message;

  FriendRequestEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.status = FriendRequestStatus.pending,
    required this.createdAt,
    this.responsedAt,
    this.message,
  });
}
