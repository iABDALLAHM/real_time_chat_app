import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
      },
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat),
          const SizedBox(width: 4),
          Text("New Chat"),
        ],
      ),
    );
  }
}
