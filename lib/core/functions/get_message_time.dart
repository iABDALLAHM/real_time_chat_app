import 'package:intl/intl.dart';

String getMessageTime({required DateTime? time}) {
    final now = DateTime.now();
    final difference = now.difference(time!);
    if (difference.inSeconds < 30) {
      return "Just Now";
    } else {
      return "${DateFormat("h").format(time)}:${time.minute} ${time.hour <= 12 ? "AM" : "PM"}";
    }
  }