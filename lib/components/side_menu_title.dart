import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/text_style.dart';

class SideMenuTitle extends StatelessWidget {
  final String name;

  const SideMenuTitle({
    super.key, required this.name
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: Font(size: 22),
      ),
      subtitle: Text(
        TimeOfDay.now().hour < 12 ? "Good morning!" : "Good afternoon!",
        style: Font(size: 16, color: Colors.grey),
      ),
    );
  }
}