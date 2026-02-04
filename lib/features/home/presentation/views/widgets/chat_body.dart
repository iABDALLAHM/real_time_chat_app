import 'package:flutter/material.dart';
import 'package:real_time_chat_app/core/widgets/custom_text_form_field.dart';
import 'package:real_time_chat_app/features/home/presentation/function/build_chat_body_app_bar.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/custom_floating_action_button.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/separated_sections_item.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(),
      appBar: buildChatBodyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
          ],
        ),
      ),
    );
  }
}
