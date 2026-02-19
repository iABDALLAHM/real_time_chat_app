import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, required this.onChange});
  final Function(int) onChange;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        onChange(2);
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
