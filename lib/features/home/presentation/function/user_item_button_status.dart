import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_accept_button.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_blocked_button.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_cancel_button.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_request_sent_button.dart';
import '../../../../core/widgets/custom_button.dart';

Widget userItemButtonStatus({
  required UserRelationshipStatus relationshipStatus,
  required Function() onTap,
}) {
  switch (relationshipStatus) {
    case UserRelationshipStatus.none:
      return CustomButton(
        onPressed: onTap,
        child: Row(
          children: [
            Icon(Icons.person_add),
            const SizedBox(width: 5),
            Text("Add"),
          ],
        ),
      );

    case UserRelationshipStatus.friendRequestSent:
      return Column(
        children: [CustomRequestSentButton(), CustomCancelButton()],
      );

    case UserRelationshipStatus.friendRequestReceived:
      return CustomAcceptButton();

    case UserRelationshipStatus.friends:
      return SizedBox.shrink();

    case UserRelationshipStatus.blocked:
      return CustomBlockedButton(onTap: onTap);
  }
}
