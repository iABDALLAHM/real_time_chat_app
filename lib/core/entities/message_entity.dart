enum MessageType { text }

class MessageEntity {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timeStamp;
  final bool isRead;
  final bool isEdited;
  final DateTime? editedAt;
  final MessageType type;

  MessageEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timeStamp,
    this.isRead = false,
    this.isEdited = false,
    this.editedAt,
    this.type = MessageType.text,
  });
}
