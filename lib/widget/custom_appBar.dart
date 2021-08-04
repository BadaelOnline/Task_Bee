import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget icon;
  // final Widget sarecheIcon;
  // final Function search;
  // final Function trans;

  CustomAppBar(
    this.icon,
    // this.sarecheIcon,
    this.title,
    // this.search,
    // this.trans,
  );
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber[400],
      title: Text(title),
      leading: icon,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 30,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.cancel_outlined,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
