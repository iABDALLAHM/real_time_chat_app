import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

import '../../../../core/widgets/custom_button.dart';

Widget userItemButtonStatus({
  required UserRelationshipStatus relationshipStatus,
}) {
  switch (relationshipStatus) {
    case UserRelationshipStatus.none:
      return CustomButton(child: Text("Add Friend"), onPressed: () {});

    case UserRelationshipStatus.friendRequestSent:
      return CustomButton(child: Text("Request sent"), onPressed: () {});

    case UserRelationshipStatus.friendRequestReceived:
      return CustomButton(child: Text("Accept Request"), onPressed: () {});

    case UserRelationshipStatus.friends:
      return CustomButton(child: Text("Message"), onPressed: () {});

    case UserRelationshipStatus.blocked:
      return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.errorColor.withOpacity(0.1),
          border: Border.all(color: AppTheme.errorColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.block, color: AppTheme.errorColor, size: 16),
            const SizedBox(width: 4),
            Text(
              "Blocked",
              style: TextStyle(
                color: AppTheme.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
  }
}
