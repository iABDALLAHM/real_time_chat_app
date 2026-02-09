class FriendshipEntity {
  final String id;
  final String user1Id;
  final String user2Id;
  final DateTime createdAt;
  final bool isBlocked;
  final String? blockedBy;

  FriendshipEntity({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.createdAt,
    this.isBlocked = false,
    this.blockedBy,
  });

  String getOtherUserId({required String currentUserId}) {
    return currentUserId == user1Id ? user2Id : user1Id;
  }

  bool isBlockedBy({required String userId}) {
    return isBlocked && blockedBy == userId;
  }
}
