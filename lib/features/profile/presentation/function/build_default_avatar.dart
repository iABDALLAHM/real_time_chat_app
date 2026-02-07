import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';

Widget buildDefaultAvatar({required BuildContext context}) {
  return Text(
    getUserData().displayName[0].toUpperCase(),
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 32,
    ),
  );
}
