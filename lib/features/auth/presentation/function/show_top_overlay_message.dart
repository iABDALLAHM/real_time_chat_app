import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';

void showTopOverlayMessage(BuildContext context, {required String message}) {
  final overlay = Overlay.of(context);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.85),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);

  Future.delayed(const Duration(seconds: 2), () {
    entry.remove();
  });
}
