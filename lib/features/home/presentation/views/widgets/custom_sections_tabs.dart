import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/separated_sections_item.dart';

class CustomSectionsTabs extends StatefulWidget {
  const CustomSectionsTabs({super.key, required this.onChange});
  final Function(int) onChange;
  @override
  State<CustomSectionsTabs> createState() => _CustomSectionsTabsState();
}

class _CustomSectionsTabsState extends State<CustomSectionsTabs> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          SeparatedSectionsItem(
            title: "All",
            isSelected: selectedIndex == 0 ? true : false,
            onPressed: () {
              selectedIndex = 0;
              widget.onChange(selectedIndex);
              setState(() {});
            },
          ),
          SeparatedSectionsItem(
            title: "Unread",
            isSelected: selectedIndex == 1 ? true : false,
            count: 0,
            onPressed: () {
              selectedIndex = 1;
              widget.onChange(selectedIndex);
              setState(() {});
            },
          ),
          SeparatedSectionsItem(
            title: "Recent",
            isSelected: selectedIndex == 2 ? true : false,
            count: 0,
            onPressed: () {
              selectedIndex = 2;
              widget.onChange(selectedIndex);
              setState(() {});
            },
          ),
          SeparatedSectionsItem(
            title: "Active",
            isSelected: selectedIndex == 3 ? true : false,
            count: 0,
            onPressed: () {
              selectedIndex = 3;
              widget.onChange(selectedIndex);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
