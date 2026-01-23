import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/auth/presentation/views/widgets/custom_divider.dart';

class CustomOrSection extends StatelessWidget {
  const CustomOrSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomDivider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("OR", style: Theme.of(context).textTheme.bodySmall),
        ),
        Expanded(child: CustomDivider()),
      ],
    );
  }
}
