import 'package:flutter/material.dart';
class MyVerticalDivider extends StatelessWidget {
  double width;
  double height;
  Color color;
 MyVerticalDivider({this.width,this.height,this.color});
  @override
  Widget build(BuildContext context) {
    return new Container(
      height:height,
      width: width,
      decoration: BoxDecoration(color:color),
    
    );
  }
}