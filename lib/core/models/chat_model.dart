import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final List<String> participants;
  final DateTime? lastMessageTime;
  final String? lastMessage;
  final String? lastMessageSenderId;
  final Map<String, int> unreadCount;
  final Map<String, bool> deletedBy;
  final Map<String, DateTime?> deletedAt;
  final Map<String, DateTime?> lastSeenBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChatModel({
    required this.id,
    required this.participants,
    this.lastMessageTime,
    this.lastMessage,
    this.lastMessageSenderId,
    required this.unreadCount,
    this.deletedBy = const {},
    this.deletedAt = const {},
    this.lastSeenBy = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "participants": participants,
      "lastMessage": lastMessage,
      "lastMessageTime": lastMessageTime,
      "lastMessageSenderId": lastMessageSenderId,
      "unreadCount": unreadCount,
      "deletedBy": deletedBy,
      "deletedAt": deletedAt.map((key, value) => MapEntry(key, value)),
      "lastSeenBy": lastSeenBy.map((key, value) => MapEntry(key, value)),
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    Map<String, DateTime?> lastSeenMap = {};
    if (map["lastSeenBy"] != null) {
      Map<String, dynamic> rawLastSeen = Map<String, dynamic>.from(
        map["lastSeenBy"],
      );
      lastSeenMap = rawLastSeen.map(
        (key, value) => MapEntry(
          key,
          value != null ? DateTime.fromMillisecondsSinceEpoch(value) : null,
        ),
      );
    }
    Map<String, DateTime?> deletedAtMap = {};
    if (map["deletedAt"] != null) {
      Map<String, dynamic> rawDeletedAt = Map<String, dynamic>.from(
        map["lastSeenBy"],
      );
      deletedAtMap = rawDeletedAt.map(
        (key, value) => MapEntry(
          key,
          value != null ? DateTime.fromMillisecondsSinceEpoch(value) : null,
        ),
      );
    }

    return ChatModel(
      id: map["id"] ?? "",
      participants: List<String>.from(map["participants"] ?? []),
      lastMessage: map["lastMessage"],
      lastMessageTime: (map["lastMessageTime"] as Timestamp).toDate(),
      lastMessageSenderId: map["lastMessageSenderId"],
      unreadCount: Map<String, int>.from(map["unreadCount"]),
      deletedBy: Map<String, bool>.from(map["deletedBy"]),
      deletedAt: deletedAtMap,
      lastSeenBy: lastSeenMap,
      createdAt: (map["createdAt"] as Timestamp).toDate(),
      updatedAt: (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  String getOtherParticipant({required String currentUserId}) {
    return participants.firstWhere(
      (id) => id != currentUserId,
      orElse: () => "",
    );
  }

  int getUnreadCount({required String userId}) {
    return unreadCount[userId] ?? 0;
  }

  bool isDeletedBy({required String userId}) {
    return deletedBy[userId] ?? false;
  }

  DateTime? getDeletedAt({required String userId}) {
    return deletedAt[userId];
  }

  DateTime? getLastSeenBy({required String userId}) {
    return lastSeenBy[userId];
  }

  bool isMessageSeen({
    required String currentUserId,
    required String otherUserId,
  }) {
    if (lastMessageSenderId == currentUserId) {
      final otherUserLastSeen = getLastSeenBy(userId: otherUserId);
      if (otherUserLastSeen != null && lastMessageTime != null) {
        return otherUserLastSeen.isAfter(lastMessageTime!) ||
            otherUserLastSeen.isAtSameMomentAs(lastMessageTime!);
      }
    }
    return false;
  }
}
