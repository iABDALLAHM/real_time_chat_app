import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text }

class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timeStamp;
  final bool isRead;
  final bool isEdited;
  final DateTime? editedAt;
  final MessageType type;

  MessageModel({
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
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map["id"],
      senderId: map["senderId"],
      receiverId: map["receiverId"],
      content: map["content"],
      type: MessageType.values.firstWhere(
        (e) => e.name == (map["type"] ?? "text"),
        orElse: () => MessageType.text,
      ),
      timeStamp: (map["timeStamp"] as Timestamp).toDate(),
      isRead: map["isRead"],
      isEdited: map["isEdited"],
      editedAt: (map["isEdited"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,
      "content": content,
      "type": type.name,
      "timeStamp": timeStamp,
      "isRead": isRead,
      "isEdited": isEdited,
      "editedAt": editedAt,
    };
  }
}