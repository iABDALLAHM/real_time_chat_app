import 'package:real_time_chat_app/core/enums/message_type.dart';

class MessageEntity {
  final String id;
  final String participants;
  final String messageSenderId;
  final String messageReceiverId;
  final String content;
  final DateTime timeStamp;
  final bool isRead;
  final bool isEdited;
  final DateTime? editedAt;
  final MessageType type;

  MessageEntity({
    required this.id,
    required this.messageSenderId,
    required this.messageReceiverId,
    required this.content,
    required this.timeStamp,
    this.isRead = false,
    this.isEdited = false,
    this.editedAt,
    this.type = MessageType.text, required this.participants,
  });
}
