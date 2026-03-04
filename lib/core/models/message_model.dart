import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/core/entities/message_entity.dart';
import 'package:real_time_chat_app/core/enums/message_type.dart';

class MessageModel {
  final String id;
  final String messageSenderId;
  final String messageReceiverId;
  final String content;
  final DateTime timeStamp;
  final bool isRead;
  final bool isEdited;
  final String participants;
  final DateTime? editedAt;
  final MessageType type;

  MessageModel({
    required this.id,
    required this.messageSenderId,
    required this.messageReceiverId,
    required this.content,
    required this.timeStamp,
    this.isRead = false,
    this.isEdited = false,
    this.editedAt,
    this.type = MessageType.text,
    required this.participants,
  });
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      participants: map["participants"],
      id: map["id"],
      messageSenderId: map["messageSenderId"],
      messageReceiverId: map["messageReceiverId"],
      content: map["content"],
      type: MessageType.values.firstWhere(
        (e) => e.name == (map["type"] ?? "text"),
        orElse: () => MessageType.text,
      ),
      timeStamp: (map["timeStamp"] as Timestamp).toDate(),
      isRead: map["isRead"],
      isEdited: map["isEdited"],
      editedAt: map["editedAt"] != null
          ? (map["editedAt"] as Timestamp).toDate()
          : null,
    );
  }

  factory MessageModel.formEntity({required MessageEntity messageEntity}) {
    return MessageModel(
      id: messageEntity.id,
      messageSenderId: messageEntity.messageSenderId,
      messageReceiverId: messageEntity.messageReceiverId,
      content: messageEntity.content,
      timeStamp: messageEntity.timeStamp,
      participants: messageEntity.participants,
    );
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      messageSenderId: messageSenderId,
      messageReceiverId: messageReceiverId,
      content: content,
      timeStamp: timeStamp,
      participants: participants,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "participants": participants,
      "messageSenderId": messageSenderId,
      "messageReceiverId": messageReceiverId,
      "content": content,
      "type": type.name,
      "timeStamp": timeStamp,
      "isRead": isRead,
      "isEdited": isEdited,
      "editedAt": editedAt,
    };
  }
}
