import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/features/profile/presentation/views/widgets/user_status.dart';

class OnlineOrOfflineStatus extends StatelessWidget {
  const OnlineOrOfflineStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: getUserData().isOnline
            ? AppTheme.successColor.withOpacity(0.1)
            : AppTheme.textsecondaryColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: getUserData().isOnline
                  ? AppTheme.successColor
                  : AppTheme.textsecondaryColor,
            ),
          ),
    
          const SizedBox(width: 6),
    
          UserStatus(),
        ],
      ),
    );
  }
}
