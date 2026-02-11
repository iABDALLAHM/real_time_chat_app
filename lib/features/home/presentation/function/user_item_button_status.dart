import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/enums/user_relationship_status.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_blocked_button.dart';
import '../../../../core/widgets/custom_button.dart';

Widget userItemButtonStatus({
  required UserRelationshipStatus relationshipStatus,
  required Function() onTap,
}) {
  switch (relationshipStatus) {
    case UserRelationshipStatus.none:
      return CustomButton(
        onPressed: onTap,
        child: Row(
          children: [
            Icon(Icons.person_add),
            const SizedBox(width: 5),
            Text("Add"),
          ],
        ),
      );

    case UserRelationshipStatus.friendRequestSent:
      return Column(
        children: [CustomRequestSentButton(), CustomCancelButton()],
      );

    case UserRelationshipStatus.friendRequestReceived:
      return CustomAcceptButton();

    case UserRelationshipStatus.friends:
      return SizedBox.shrink();

    case UserRelationshipStatus.blocked:
      return CustomBlockedButton(onTap: onTap);
  }
}

class CustomAcceptButton extends StatelessWidget {
  const CustomAcceptButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      label: Text("Accept", style: TextStyle(fontSize: 10)),
      icon: Icon(Icons.check),
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.green),
        backgroundColor: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }
}

class CustomCancelButton extends StatelessWidget {
  const CustomCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      label: Text("Cancel", style: TextStyle(fontSize: 10)),
      icon: Icon(Icons.cancel_outlined),
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Colors.redAccent),
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        minimumSize: Size(0, 24),
      ),
    );
  }
}

class CustomRequestSentButton extends StatelessWidget {
  const CustomRequestSentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.access_time, size: 16, color: Colors.orange),
          const SizedBox(width: 4),
          Text(
            "Request sent",
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
