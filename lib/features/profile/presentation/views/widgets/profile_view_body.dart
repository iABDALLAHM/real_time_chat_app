import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/functions/get_user_data.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/profile/presentation/function/build_default_avatar.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor,
                    child: getUserData().photoUrl == null
                        ? ClipOval(child: SizedBox(width: 120, height: 120))
                        : buildDefaultAvatar(),
                  ),
                ),

                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            Text(
              getUserData().displayName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              getUserData().email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textsecondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: getUserData().isOnline
                    ? AppTheme.successColor.withOpacity(0.1)
                    : AppTheme.textsecondaryColor.withOpacity(0.1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: getUserData().isOnline
                          ? AppTheme.successColor
                          : AppTheme.textsecondaryColor,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Text(
                    getUserData().isOnline ? "Online" : "Offline",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: getUserData().isOnline
                          ? AppTheme.successColor
                          : AppTheme.textsecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${getUserData().createdAt.day}-${getUserData().createdAt.month}-${getUserData().createdAt.year}",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textsecondaryColor,
              ),
            ),
            const SizedBox(height: 32),

            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 32),
                    CustomTextFormField(
                      labelText: "Display Name",
                      hintText: getUserData().displayName,
                      onSaved: (value) {},
                      prefixIcon: Icon(Icons.person_outlined),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      helperText: "Email can't be changed",
                      labelText: "Email",
                      hintText: getUserData().email,
                      onSaved: (value) {},
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Change Password"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Icon(
                          Icons.security,
                          color: AppTheme.primaryColor,
                        ),
                        onTap: () {
                          // navigate to change password view
                        },
                      ),

                      Divider(height: 1, color: Colors.grey),

                      ListTile(
                        title: Text("Delete Account"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Icon(
                          Icons.delete_forever,
                          color: AppTheme.errorColor,
                        ),
                        onTap: () {
                          // navigate to delete password view
                        },
                      ),

                      Divider(height: 1, color: Colors.grey),

                      ListTile(
                        title: Text("Sign Out"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Icon(Icons.logout, color: AppTheme.errorColor),
                        onTap: () {
                          // navigate to signOut  view
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  "ChatApp v1.0.0",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textsecondaryColor,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
