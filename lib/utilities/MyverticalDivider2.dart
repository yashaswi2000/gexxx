import 'package:flutter/material.dart';
class MyVerticalDivider2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height*0.15,
      width: 1.0,
      color: Colors.white,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}