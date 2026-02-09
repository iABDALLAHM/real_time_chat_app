import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';

class ReceviedRequestTap extends StatelessWidget {
  const ReceviedRequestTap({super.key});

  @override
  Widget build(BuildContext context) {
    return ReceviedEmptyStateWidget();
  }
}

class ReceviedEmptyStateWidget extends StatelessWidget {
  const ReceviedEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.inbox_outlined,
                size: 40,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "No Friend Requests",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "When someone sends you a friend request, it will appear here.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textsecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            CustomButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_search),
                  const SizedBox(width: 10),
                  Text("View Friends Requests"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

