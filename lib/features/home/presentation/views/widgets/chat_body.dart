import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/utils/app_theme.dart';
import 'package:real_time_chat_app/core/widgets/custom_button.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/home/presentation/function/build_chat_body_app_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_floating_action_button.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/separated_sections_item.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(),
      appBar: buildChatBodyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: "Enter To search conversations",
                hintText: "Search conversations...",
                onSaved: (value) {},
                prefixIcon: Icon(Icons.search),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    List<SeparatedSectionsItem> itemsList = [
                      SeparatedSectionsItem(title: "All", isSelected: true),
                      SeparatedSectionsItem(
                        title: "Unread",
                        isSelected: false,
                        count: 0,
                      ),
                      SeparatedSectionsItem(
                        title: "Recent",
                        isSelected: false,
                        count: 0,
                      ),
                      SeparatedSectionsItem(
                        title: "Active",
                        isSelected: false,
                        count: 0,
                      ),
                    ];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: itemsList[index],
                    );
                  },
                ),
              ),
              NoConversationsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class NoConversationsWidget extends StatelessWidget {
  const NoConversationsWidget({super.key});

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
            onPressed: () {},
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
            onPressed: () {},
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
