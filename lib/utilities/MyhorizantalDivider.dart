import 'package:flutter/material.dart';
class MyhorizontalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 2,
      width: MediaQuery.of(context).size.width*0.8,
      
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}