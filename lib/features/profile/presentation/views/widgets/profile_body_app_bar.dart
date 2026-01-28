// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:real_time_chat_app/core/utils/app_theme.dart';
// import 'package:real_time_chat_app/features/profile/controllers/profile_controller.dart';

// class ProfileBodyAppBar extends StatelessWidget {
//   const ProfileBodyAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = context.watch<ProfileController>();
//     return Row(
//       children: [
//         IconButton(
//           padding: EdgeInsets.zero,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back),
//         ),
//         Spacer(),
//         Text(
//           "Profile",
//           style: Theme.of(
//             context,
//           ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//         ),
//         Spacer(),
//         TextButton(
//           onPressed: () {
//             controller.toggleEdit();
//           },
//           child: Text(
//             controller.isEditing ? 'Cancel' : 'Edit',
//             style: TextStyle(
//               color: controller.isEditing
//                   ? AppTheme.errorColor
//                   : AppTheme.primaryColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
