class FriendshipEntity {
  final String id;
  final List<String> userIds;
  final DateTime createdAt;
  final bool isBlocked;
  final String? blockedBy;

  FriendshipEntity({
    required this.id,
    required this.userIds,
    required this.createdAt,
    this.isBlocked = false,
    this.blockedBy,
  });
}
