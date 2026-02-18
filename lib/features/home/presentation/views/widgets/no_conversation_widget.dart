import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';

class NoConversationsWidget extends StatelessWidget {
  const NoConversationsWidget({super.key, required this.onChange});
  final Function(int) onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(80),
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 70,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "No Conversations Yet",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Conversat with friends and",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textsecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          CustomButton(
            onPressed: () {
              onChange(1);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_search),
                const SizedBox(width: 10),
                Text("Find People"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          CustomButton(
            isSecondButton: true,
            onPressed: () {
              onChange(2);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_2_outlined),
                const SizedBox(width: 10),
                Text("View Friends"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
