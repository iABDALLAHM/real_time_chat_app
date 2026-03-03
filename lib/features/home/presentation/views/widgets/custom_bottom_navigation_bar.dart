import 'package:flutter/material.dart';
import 'package:real_time_chat_app/features/home/domain/entities/bottom_navigation_item_entity.dart';
import 'package:real_time_chat_app/features/home/presentation/views/widgets/navigation_icon.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.onChange,
    required this.currentIndex,
  });
  final ValueChanged<int> onChange;
  final int currentIndex;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
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
          return NavigationIcon(
            onTap: () {
              widget.onChange(key);
              setState(() {});
            },
            navigationItemEntity: value,
            isActive: widget.currentIndex == key ? true : false,
          );
        }).toList(),
      ),
    );
  }
}
