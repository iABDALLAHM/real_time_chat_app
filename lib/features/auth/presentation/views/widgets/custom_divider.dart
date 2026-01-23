
import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppTheme.borderColor);
  }
}
