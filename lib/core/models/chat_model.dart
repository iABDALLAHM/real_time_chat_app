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
    return ChatModel(
      id: map["id"],
      participants: map["participants"],
      unreadCount: map["unreadCount"],
      createdAt: map["createdAt"],
      updatedAt: map["updatedAt"],
    );
  }
}
