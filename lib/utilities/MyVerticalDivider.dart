import 'package:flutter/material.dart';
class MyVerticalDivider extends StatelessWidget {
  double width;
  double height;
  Color color;
 MyVerticalDivider({this.width,this.height,this.color});
  @override
  Widget build(BuildContext context) {
    return new Container(
<<<<<<< Updated upstream
      height: 30.0,
      width: 1.0,
      color: Colors.white,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
=======
      height:height,
      width: width,
      decoration: BoxDecoration(color:color),
    
>>>>>>> Stashed changes
    );
  }
}