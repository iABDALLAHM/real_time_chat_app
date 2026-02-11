import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/core/entities/user_entity.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/presentation/function/user_item_button_status.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key, required this.userEntity, required this.onTap});
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEntity.email,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textsecondaryColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                userItemButtonStatus(
                  relationshipStatus: UserRelationshipStatus.blocked,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
