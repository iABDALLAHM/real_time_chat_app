class UserEntity {
  final String uId;
  final String email;
  final String displayName;
  String? photoUrl;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime createdAt;

  UserEntity({
    required this.uId,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.isOnline = false,
    required this.lastSeen,
    required this.createdAt,
  });
}
