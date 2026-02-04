import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class SeparatedSectionsItem extends StatelessWidget {
  const SeparatedSectionsItem({
    super.key,
    required this.title,
    this.count,
    required this.isSelected,
  });
  final String title;
  final int? count;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [count != null ? Text("$title ($count)") : Text(title)],
      ),
    );
  }
}