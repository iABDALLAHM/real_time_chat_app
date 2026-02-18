import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/home/domain/entities/bottom_navigation_item_entity.dart';

class NavigationIcon extends StatelessWidget {
  const NavigationIcon({
    super.key,
    required this.navigationItemEntity,
    required this.isActive,
    required this.onTap,
  });
  final BottomNavigationItemEntity navigationItemEntity;
  final bool isActive;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              navigationItemEntity.icon,
              color: isActive ? AppTheme.primaryColor : null,
            ),
            const SizedBox(height: 8),
            Text(
              navigationItemEntity.text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isActive ? AppTheme.primaryColor : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
