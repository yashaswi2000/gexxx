import 'package:flutter/material.dart';
class MyVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Theme.of(context).brightness==Brightness.light?Colors.teal:Colors.white,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}