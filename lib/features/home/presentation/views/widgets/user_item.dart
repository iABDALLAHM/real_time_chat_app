import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/controllers/user_list_controller.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.userEntity,
    required this.onTap,
  });
  final UserEntity userEntity;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.primaryColor,
              child: Text(
                userEntity.displayName.isNotEmpty
                    ? userEntity.displayName.toUpperCase()[0]
                    : "?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userEntity.displayName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEntity.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textsecondaryColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                buildActionButton(
                  relationshipStatus: UserRelationshipStatus.none,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildActionButton({required UserRelationshipStatus relationshipStatus}) {
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
