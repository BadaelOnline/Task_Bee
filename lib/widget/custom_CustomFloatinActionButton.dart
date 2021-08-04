import 'package:flutter/material.dart';

class CustomFloatinActionButton extends StatelessWidget {
  final Widget icon;
  final Function onPressed;
  CustomFloatinActionButton({
    @required this.icon,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber[400],
      onPressed: onPressed(),
      child: Icon(
        Icons.add,
        color: Colors.blue,
        size: 25,
      ),
    );
  }
}
