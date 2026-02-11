import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_blocked_button.dart';
import '../../../../core/widgets/custom_button.dart';

Widget userItemButtonStatus({
  required UserRelationshipStatus relationshipStatus,
  required Function() onTap,
}) {
  switch (relationshipStatus) {
    case UserRelationshipStatus.none:
      return CustomButton(onPressed: onTap, child: Text("Add Friend"));

    case UserRelationshipStatus.friendRequestSent:
      return CustomButton(onPressed: onTap, child: Text("Request sent"));

    case UserRelationshipStatus.friendRequestReceived:
      return CustomButton(onPressed: onTap, child: Text("Accept Request"));

    case UserRelationshipStatus.friends:
      return CustomButton(onPressed: onTap, child: Text("Message"));

    case UserRelationshipStatus.blocked:
      return CustomBlockedButton(onTap: onTap);
  }
}
