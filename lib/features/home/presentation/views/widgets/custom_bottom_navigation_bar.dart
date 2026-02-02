import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/domain/entities/bottom_navigation_item_entity.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/navigation_icon.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.onChange});
  final ValueChanged<int> onChange;
  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.grey,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: bottomNAvigationList.asMap().entries.map((element) {
          var key = element.key;
          var value = element.value;
          return GestureDetector(
            onTap: () {
              currentIndex = key;
              widget.onChange(currentIndex);
              setState(() {});
            },
            child: NavigationIcon(
              navigationItemEntity: value,
              isActive: currentIndex == key ? true : false,
            ),
          );
        }).toList(),
      ),
    );
  }
}
